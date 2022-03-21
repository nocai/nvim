-- nv varables
vim.g.neovide_cursor_vfx_mode = "railgun"

vim.nv = {
	user_home = os.getenv("HOME"),
	home = os.getenv("HOME") .. "/.config/nvim",

	is_mac = jit.os == "OSX",
	is_linux = jit.os == "Linux",
	is_vscode = vim.g.vscode == 1,

	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},

	ui = {
		theme = "sonokai",
		italic = true,
		transparency = false,
	},
}

-- disable distribution plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1

require("option")
require("autocmd")
require("plugins")
