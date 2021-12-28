-- nv varables
vim.nv = {
	user_home = os.getenv("HOME"),
	packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim",
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
		theme = "gruvbox-material",
		-- theme = "sonokai",
		italic_comments = true,
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
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1

-- v:lua
-- v:lua.check_back_space()
-- function _G.check_back_space()
--   local col = vim.fn.col(".") - 1
--   if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--     return true
--   else
--     return false
--   end
-- end
