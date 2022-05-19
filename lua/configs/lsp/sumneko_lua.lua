-- sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = runtime_path },
			diagnostics = { enable = true, globals = { "vim", "redis", "nvim" } },
			hint = { enable = true },
			workspace = {
				-- library = vim.api.nvim_get_runtime_file("", true),

				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
}
