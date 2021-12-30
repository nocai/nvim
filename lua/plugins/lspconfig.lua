local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
lspSymbol("Error", vim.nv.diagnostics.icons.error)
lspSymbol("Info", vim.nv.diagnostics.icons.info)
lspSymbol("Hint", vim.nv.diagnostics.icons.hint)
lspSymbol("Warn", vim.nv.diagnostics.icons.warning)

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		spacing = 0,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({ { msg } }, true, {})
	end
end

local function lspconfig()
	local on_attach = function(client, bufnr)
		if client.resolved_capabilities.document_highlight then
			vim.cmd([[
					augroup lsp_document_highlight
						autocmd!
						autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
						autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
					augroup END
				]])
		end

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		local opts = { noremap = true, silent = true }
		buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
		-- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

		-- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		-- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		-- buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
		-- buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		-- buf_set_keymap("x", "ga", "<cmd><c-u>lua vim.lsp.buf.code_action()<CR>", opts)

		buf_set_keymap("n", "E", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("v", "<C-e>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

		buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

		-- formatting
		buf_set_keymap("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

		-- format on save
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.api.nvim_command([[augroup Format]])
		-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
		-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
		-- 	vim.api.nvim_command([[augroup END]])
		-- end

		-- LSP
		buf_set_keymap(
			"n",
			"ga",
			[[<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>]],
			opts
		)
		buf_set_keymap(
			"v",
			"ga",
			[[<cmd>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor({}))<CR>]],
			opts
		)
		buf_set_keymap(
			"n",
			"gs",
			[[<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
		buf_set_keymap(
			"n",
			"gr",
			[[<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
		buf_set_keymap(
			"n",
			"gi",
			[[<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)

		buf_set_keymap(
			"n",
			"<leader>ld",
			[[<cmd>lua require('telescope.builtin').lsp_diagnostics(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.documentationFormat = {
		"markdown",
		"plaintext",
	}
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.preselectSupport = true
	capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
	capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
	capabilities.textDocument.completion.completionItem.deprecatedSupport = true
	capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
	capabilities.textDocument.completion.completionItem.tagSupport = {
		valueSet = { 1 },
	}
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}

	local lspc = require("lspconfig")

	-- gopls
	lspc.gopls.setup({
		cmd = { "gopls", "--remote=auto" },
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			analyses = {
				unreachable = true,
				unusedparams = true,
			},
			staticcheck = true,
		},
	})

	-- sumneko_lua
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	lspc.sumneko_lua.setup({
		cmd = { "lua-language-server" },
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT", path = runtime_path },
				diagnostics = { enable = true, globals = { "vim" } },
				hint = { enable = true },
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		},
	})

	-- java
	local util = require("lspconfig.util")
	local sysname = vim.loop.os_uname().sysname
	local env = {
		HOME = vim.loop.os_homedir(),
		JAVA_HOME = os.getenv("JAVA_HOME"),
		JDTLS_HOME = os.getenv("JDTLS_HOME"),
		WORKSPACE = os.getenv("WORKSPACE"),
	}
	local function get_java_executable()
		local executable = env.JAVA_HOME and util.path.join(env.JAVA_HOME, "bin", "java") or "java"
		return sysname:match("Windows") and executable .. ".exe" or executable
	end
	local function get_jdtls_jar()
		return vim.fn.expand("$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar")
	end
	local function get_jdtls_config()
		if sysname:match("Linux") then
			return util.path.join(env.JDTLS_HOME, "config_linux")
		elseif sysname:match("Darwin") then
			return util.path.join(env.JDTLS_HOME, "config_mac")
		elseif sysname:match("Windows") then
			return util.path.join(env.JDTLS_HOME, "config_win")
		else
			return util.path.join(env.JDTLS_HOME, "config_linux")
		end
	end
	local function get_workspace_dir()
		return env.WORKSPACE and env.WORKSPACE or util.path.join(env.HOME, "workspace")
	end
	lspc.jdtls.setup({
		cmd = {
			get_java_executable(),
			-- "jdtls",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"-Xmx2G",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-javaagent:/usr/share/java/jdtls/plugins/lombok.jar",
			"-jar",
			get_jdtls_jar(),
			"-configuration",
			get_jdtls_config(),
			"-data",
			get_workspace_dir(),
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})

	lspc.denols.setup({ on_attach = on_attach, capabilities = capabilities })
	lspc.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- rust-analyzer
	lspc.rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- cmd = {vim.g.home.."/.local/bin/rust-analyzer-linux"}
	})

	-- python
	-- lspc.jedi_language_server.setup {
	--   on_attach = on_attach,
	--   capabilities = capabilities
	-- }
	require("lspconfig").pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- c/c++
	-- lspconfig.ccls.setup {
	--   on_attach = on_attach,
	--   capabilities = capabilities,
	--   init_options = {
	--     compilationDatabaseDirectory = "build";
	--     index = {
	--       threads = 0;
	--     };
	--     clang = {
	--       excludeArgs = { "-frounding-math"} ;
	--     };
	--   }
	-- }
	lspc.clangd.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "clangd", "--background-index" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		single_file_support = true,
	})
end

-- vim.lsp.set_log_level("debug")
return {
	{
		"neovim/nvim-lspconfig",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "BufReadPre",
		config = lspconfig,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		after = { "nvim-lspconfig" },
		config = function()
			local ls = require("null-ls")
			ls.setup({
				sources = {
					ls.builtins.formatting.stylua,
					ls.builtins.formatting.prettier.with({
						filetypes = { "html", "json", "yaml", "markdown" },
					}),
					-- ls.builtins.diagnostics.eslint,
					-- ls.builtins.completion.spell,
				},
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		keys = "gO",
		after = { "nvim-lspconfig" },
		requires = { "neovim/nvim-lspconfig" },
		config = function()
			vim.g.symbols_outline = {
				auto_preview = false,
			}
			vim.api.nvim_set_keymap("n", "gO", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
		end,
	},
}
