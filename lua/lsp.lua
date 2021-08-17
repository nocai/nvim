require("global")

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = true,
})

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

	buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	buf_set_keymap('n', 'E', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)


	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- formatting
	-- buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

local lspconfig = require('lspconfig')

-- gopls
lspconfig.gopls.setup {
	cmd = {"gopls","--remote=auto"},
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders=true,
		completeUnimported=true,
		analyses = {
			unreachable= true,
			unusedparams= true,
		},
		staticcheck = true,
		-- codelenses = {
		-- 	generate = true,
		-- 	tidy = true,
		-- }
	}
}

-- sumneko_lua
local sumneko_root_path = vim.g.home..'/lua-language-server'
if vim.g.is_macOS then
	sumneko_root_path = vim.g.nvim_home..'/.lsp/lua-language-server'
end
local system_name = "macOS" -- (Linux, macOS, or Windows)
if jit.os == "Linux" then
	system_name = "Linux"
end
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = {"vim","packer_plugins"}
			},
			runtime = {version = "LuaJIT", path = runtime_path},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					[vim.fn.expand(vim.g.home..'/.local/share/nvim/site/pack/packer')] = true,
				},
			},
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
		},
	}
}

-- rust-analyzer
lspconfig.rust_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	-- cmd = {vim.g.home.."/.local/bin/rust-analyzer-linux"}
}
