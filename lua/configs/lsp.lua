-- vim.lsp.set_log_level("debug")

local settings = require("configs.lsp_settings")
local lsp = {}

function lsp.nvim_lspconfig()
	local lspconfig = require("lspconfig")

	local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
	for _, server in ipairs(servers) do
		local config = settings.config()
		lspconfig[server].setup(config)
	end

	local items = vim.fn.globpath(nvim.home .. "/lua/configs/lsp", "*.lua", false, true)
	for _, item in ipairs(items) do
		local server = vim.fn.fnamemodify(item, ":t:r")
		local config = require("configs.lsp." .. server)
		config = settings.config(config)
		lspconfig[server].setup(config)
	end
end

function lsp.null_ls()
	local ls = require("null-ls")
	ls.setup({
		sources = {
			ls.builtins.formatting.stylua,
		},
	})
end

function lsp.lsp_signature()
	require("lsp_signature").setup({
		bind = true,
		fix_pos = true,
		hint_prefix = " ",
		max_height = 22,
		max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
		handler_opts = {
			border = "rounded", -- double, single, shadow, none
		},
		zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
		padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
	})
end
return lsp
