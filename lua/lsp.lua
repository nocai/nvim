require("global")

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

	buf_set_keymap('n', 'E', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

	buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

	buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
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
	}
}
vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting()]])

-- sumneko_lua
local sumneko_root_path = vim.g.home..'/lua-language-server'
if vim.g.is_macOS then
	sumneko_root_path = vim.g.nvim_home..'/.lsp/lua-language-server'
end
local system_name = "macOS" -- (Linux, macOS, or Windows)
if jit.os == "Linux" then
	system_name = "Linux"
end

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
			runtime = {version = "LuaJIT"},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					[vim.fn.expand(vim.g.home..'/.local/share/nvim/site/pack/packer')] = true,
				},
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
