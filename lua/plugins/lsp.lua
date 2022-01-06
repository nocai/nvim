local function lspconfig()
	local lspc = require("lspconfig")
	local on_attach, capabilities = require("plugins.lsp_config")

	-- sumneko_lua
	require("plugins.lsp.sumneko_lua").setup(lspc, on_attach, capabilities)
	-- jdtls
	require("plugins.lsp.jdtls").setup(lspc, on_attach, capabilities)

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

	-- clangd
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
					-- ls.builtins.diagnostics.eslint,
					-- ls.builtins.completion.spell,
				},
			})
		end,
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
