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

	-- Mappings
	-- formatting
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- format on save
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.api.nvim_command([[augroup Format]])
	-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
	-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
	-- 	vim.api.nvim_command([[augroup END]])
	-- end

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
		buf_set_keymap("x", "ga", "<cmd><c-u>lua vim.lsp.buf.code_action()<CR>", opts)
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
	end
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

return on_attach, capabilities
