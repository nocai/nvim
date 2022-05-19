local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
lspSymbol("Error", nvim.diagnostics.icons.error)
lspSymbol("Info", nvim.diagnostics.icons.info)
lspSymbol("Hint", nvim.diagnostics.icons.hint)
lspSymbol("Warn", nvim.diagnostics.icons.warning)

vim.diagnostic.config({
	-- virtual_text = {
	-- 	prefix = "",
	-- 	spacing = 0,
	-- },
	-- signs = true,
	update_in_insert = false,
})

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
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

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { buffer = bufnr }

	-- print(vim.inspect(client.resolved_capabilities))
	if client.resolved_capabilities.code_lens then
		-- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.cmd([[autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
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
	vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- format on save
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.api.nvim_command([[augroup Format]])
	-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
	-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
	-- 	vim.api.nvim_command([[augroup END]])
	-- end

	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	-- mapping: K => E
	vim.keymap.set("n", "E", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

	vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

	vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	-- LSP
	local ok, _ = pcall(require, "telescope")
	if not ok then
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
		vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.keymap.set("v", "ga", "<cmd><c-u>lua vim.lsp.buf.range_code_action()<CR>", opts)
	else
		vim.keymap.set(
			"n",
			"ga",
			[[<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>]],
			opts
		)
		vim.keymap.set("v", "ga", [[<cmd>Telescope lsp_range_code_actions theme=get_cursor<CR>]], opts)
		vim.keymap.set(
			"n",
			"gs",
			[[<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
		vim.keymap.set(
			"n",
			"gr",
			[[<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
		vim.keymap.set(
			"n",
			"gi",
			[[<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy({}))<CR>]],
			opts
		)
	end
end

local settings = {}

function settings.config(config)
	config = config or {}

	config.on_attach = on_attach
	config.capabilities = capabilities
	config.flags = {
		debounce_text_changes = 150,
	}
	return config
end

return settings
