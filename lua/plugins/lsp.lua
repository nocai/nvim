local function lspconfig()
	local lspc = require("lspconfig")
	local on_attach, capabilities = require("plugins.lsp.config")

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
	for _, lsp in ipairs(servers) do
		lspc[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		})
	end

	local server_ext = {}
	-- sumneko_lua
	server_ext.sumneko_lua = require("plugins.lsp.sumneko_lua")
	-- jdtls
	-- server_ext.jdtls = require("plugins.lsp.jdtls")
	-- gopls
	server_ext.gopls = require("plugins.lsp.gopls")
	-- clangd
	server_ext.clangd = require("plugins.lsp.clangd")

	for lsp, server in pairs(server_ext) do
		server.on_attach = on_attach
		server.capabilities = capabilities
		server.flags = {
			debounce_text_changes = 150,
		}
		lspc[lsp].setup(server)
	end
end

-- vim.lsp.set_log_level("debug")
return {
	{
		"neovim/nvim-lspconfig",
		cond = function()
			return not vim.g.vscode
		end,
		event = "BufReadPre",
		config = lspconfig,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		after = { "nvim-lspconfig" },
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local ls = require("null-ls")
			ls.setup({
				sources = {
					ls.builtins.formatting.stylua,
					ls.builtins.formatting.prettier.with({
						filetypes = { "html", "json", "yaml", "markdown" },
					}),
					ls.builtins.diagnostics.eslint,
					ls.builtins.completion.spell,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		cond = function()
			return not vim.g.vscode
		end
	},
	-- {
	-- 	"simrat39/symbols-outline.nvim",
	-- 	cond = function()
	-- 		return vim.g.vscode ~= 1
	-- 	end,
	-- 	keys = "gO",
	-- 	after = { "nvim-lspconfig" },
	-- 	requires = { "neovim/nvim-lspconfig" },
	-- 	config = function()
	-- 		vim.g.symbols_outline = {
	-- 			auto_preview = false,
	-- 		}
	-- 		vim.api.nvim_set_keymap("n", "gO", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
	-- 	end,
	-- },
}
