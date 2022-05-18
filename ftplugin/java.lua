local uv = vim.loop

local path = (function()
	local is_windows = uv.os_uname().version:match("Windows")

	local function sanitize(path)
		if is_windows then
			path = path:sub(1, 1):upper() .. path:sub(2)
			path = path:gsub("\\", "/")
		end
		return path
	end

	local function exists(filename)
		local stat = uv.fs_stat(filename)
		return stat and stat.type or false
	end

	local function is_dir(filename)
		return exists(filename) == "directory"
	end

	local function is_file(filename)
		return exists(filename) == "file"
	end

	local function is_fs_root(path)
		if is_windows then
			return path:match("^%a:$")
		else
			return path == "/"
		end
	end

	local function is_absolute(filename)
		if is_windows then
			return filename:match("^%a:") or filename:match("^\\\\")
		else
			return filename:match("^/")
		end
	end

	local function dirname(path)
		local strip_dir_pat = "/([^/]+)$"
		local strip_sep_pat = "/$"
		if not path or #path == 0 then
			return
		end
		local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
		if #result == 0 then
			if is_windows then
				return path:sub(1, 2):upper()
			else
				return "/"
			end
		end
		return result
	end

	local function path_join(...)
		return table.concat(vim.tbl_flatten({ ... }), "/")
	end

	-- Traverse the path calling cb along the way.
	local function traverse_parents(path, cb)
		path = uv.fs_realpath(path)
		local dir = path
		-- Just in case our algo is buggy, don't infinite loop.
		for _ = 1, 100 do
			dir = dirname(dir)
			if not dir then
				return
			end
			-- If we can't ascend further, then stop looking.
			if cb(dir, path) then
				return dir, path
			end
			if is_fs_root(dir) then
				break
			end
		end
	end

	-- Iterate the path until we find the rootdir.
	local function iterate_parents(path)
		local function it(_, v)
			if v and not is_fs_root(v) then
				v = dirname(v)
			else
				return
			end
			if v and uv.fs_realpath(v) then
				return v, path
			else
				return
			end
		end
		return it, path, path
	end

	local function is_descendant(root, path)
		if not path then
			return false
		end

		local function cb(dir, _)
			return dir == root
		end

		local dir, _ = traverse_parents(path, cb)

		return dir == root
	end

	return {
		is_dir = is_dir,
		is_file = is_file,
		is_absolute = is_absolute,
		exists = exists,
		dirname = dirname,
		join = path_join,
		sanitize = sanitize,
		traverse_parents = traverse_parents,
		iterate_parents = iterate_parents,
		is_descendant = is_descendant,
	}
end)()

local sysname = vim.loop.os_uname().sysname

local env = {
	HOME = vim.loop.os_homedir(),
	JAVA_HOME = os.getenv("JAVA_HOME"),
	JDTLS_HOME = os.getenv("JDTLS_HOME"),
	WORKSPACE = os.getenv("WORKSPACE"),
}

local function get_jdtls_jar()
	return vim.fn.expand("$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar")
end

local function get_jdtls_config()
	if sysname:match("Linux") then
		return path.join(env.JDTLS_HOME, "config_linux")
	elseif sysname:match("Darwin") then
		return path.join(env.JDTLS_HOME, "config_mac")
	elseif sysname:match("Windows") then
		return path.join(env.JDTLS_HOME, "config_win")
	else
		return path.join(env.JDTLS_HOME, "config_linux")
	end
end

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })

local function get_workspace_dir()
	-- return env.WORKSPACE and env.WORKSPACE or path.join(env.HOME, "workspace")
	return env.HOME .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	on_attach = require("configs.lsp").on_attach,
	capabilities = require("configs.lsp").make_capabilities(),
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		-- 💀
		"java", -- or '/path/to/java11_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-javaagent:/usr/share/java/jdtls/plugins/lombok.jar",
		-- 💀
		"-jar",
		get_jdtls_jar(),
		-- '-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		get_jdtls_config(),
		-- '-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		get_workspace_dir(),
		-- '-data', '/path/to/unique/per/project/workspace/folder'
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
