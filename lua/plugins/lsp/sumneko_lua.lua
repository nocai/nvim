-- sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function setup(lspc, on_attach, capabilities)
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
end

return { setup = setup }
