local M = {
	{
		"navarasu/onedark.nvim",
		event = "VimEnter",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		setup = function()
			if vim.nv.ui.transparency then
				vim.g.onedark_transparent_background = true
			end
		end,
		config = function()
			if vim.nv.ui.theme == "onedark" then
				vim.cmd("colorscheme " .. vim.nv.ui.theme)
			end
		end,
	},
	{
		"shaunsingh/nord.nvim",
		event = "VimEnter",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		config = function()
			vim.g.nord_disable_background = true
			if vim.nv.ui.theme == "nord" then
				vim.cmd("colorscheme " .. vim.nv.ui.theme)
			end
		end,
	},
	{
		"folke/tokyonight.nvim",
		event = "VimEnter",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		setup = function()
			vim.g.tokyonight_style = "night" -- storm, night, day
			vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "NvimTree" }
			if vim.nv.ui.transparency then
				vim.g.tokyonight_transparent = true
				vim.g.tokyonight_italic_functions = true
			end
		end,
		config = function()
			if vim.nv.ui.theme == "tokyonight" then
				vim.cmd("colorscheme " .. vim.nv.ui.theme)
			end
		end,
	},
	{
		"sainnhe/gruvbox-material",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "VimEnter",
		config = function()
			if vim.nv.ui.theme == "gruvbox-material" then
				-- let g:gruvbox_material_transparent_background = 1
				vim.cmd("colorscheme " .. vim.nv.ui.theme)
			end
		end,
	},
	{
		"sainnhe/sonokai",
		event = "VimEnter",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		config = function()
			if vim.nv.ui.theme == "sonokai" then
				vim.cmd("colorscheme " .. vim.nv.ui.theme)
			end
		end,
	},
}

return M
