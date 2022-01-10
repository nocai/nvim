-- lsp configs
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

-- vim.lsp.set_log_level("debug")

local lsp = {}

function lsp.on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }

	-- print(vim.inspect(client.resolved_capabilities))
	if client.resolved_capabilities.code_lens then
		-- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.cmd([[autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
	end

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
			augroup lsp_document_highlight
				autocmd!
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
	end

	-- formatting
	buf_set_keymap("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	if client.resolved_capabilities.document_formatting then
		-- format on save
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_command([[augroup Format]])
			vim.api.nvim_command([[autocmd! * <buffer>]])
			vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
			vim.api.nvim_command([[augroup END]])
		end
	end

	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	buf_set_keymap("n", "E", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("v", "<C-e>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	-- LSP
	local ok, _ = pcall(require, "telescope")
	if not ok then
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
		buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		buf_set_keymap("v", "ga", "<cmd><c-u>lua vim.lsp.buf.range_code_action()<CR>", opts)
	else
		buf_set_keymap(
			"n",
			"ga",
			[[<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>]],
			opts
		)
		buf_set_keymap(
			"v",
			"ga",
			[[<cmd>Telescope lsp_range_code_actions theme=get_cursor<CR>]],
			-- [[<cmd>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor({}))<CR>]],
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
	end
end

function lsp.make_capabilities()
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
	return capabilities
end

function lsp.lspconfig()
	local lspc = require("lspconfig")
	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
	for _, name in ipairs(servers) do
		lspc[name].setup({
			on_attach = require("plugins.lsp").on_attach,
			capabilities = require("plugins.lsp").make_capabilities(),
			flags = {
				debounce_text_changes = 150,
			},
		})
	end

	local server_ext = {}
	-- sumneko_lua
	server_ext.sumneko_lua = require("plugins.lsp.sumneko_lua")
	-- gopls
	server_ext.gopls = require("plugins.lsp.gopls")
	-- clangd
	server_ext.clangd = require("plugins.lsp.clangd")

	for name, config in pairs(server_ext) do
		config.on_attach = require("plugins.lsp").on_attach
		config.capabilities = require("plugins.lsp").make_capabilities()
		config.flags = {
			debounce_text_changes = 150,
		}
		lspc[name].setup(config)
	end
end

table.insert(lsp, {
	"neovim/nvim-lspconfig",
	cond = function()
		return not vim.g.vscode
	end,
	event = "BufReadPre",
	config = function()
		require("plugins.lsp").lspconfig()
	end,
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	cond = function()
	-- 		return not vim.g.vscode
	-- 	end,
	-- 	ft = { "lua" },
	-- 	after = { "nvim-lspconfig" },
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local ls = require("null-ls")
	-- 		ls.setup({
	-- 			sources = {
	-- 				ls.builtins.formatting.stylua,
	-- 				ls.builtins.formatting.prettier.with({
	-- 					filetypes = { "html", "json", "yaml", "markdown" },
	-- 				}),
	-- 				-- ls.builtins.diagnostics.eslint,
	-- 				-- ls.builtins.completion.spell,
	-- 			},
	-- 		})
	-- 	end,
	-- },
})

table.insert(lsp, {
	-- config, see: ftfplugin/java.lua
	"mfussenegger/nvim-jdtls",
	cond = function()
		return not vim.g.vscode
	end,
})

return lsp

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
