local ok, _ = pcall(vim.cmd, "packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present or not ok then
	local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

	-- remove the dir before cloning
	vim.fn.delete(packer_path, "rf")
	print("Cloning packer...")
	vim.fn.system({
		"git",
		"clone",
		"https://ghproxy.com/https://github.com/wbthomason/packer.nvim",
		"--depth",
		"20",
		packer_path,
	})

	vim.cmd("packadd packer.nvim")
	present, packer = pcall(require, "packer")

	if present then
		print("Packer cloned successfully.")
	else
		error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
	end
end

packer.init({
	-- compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "packer_compiled.lua"),
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 6000, -- seconds
		default_url_format = "https://ghproxy.com/https://github.com/%s",
	},
	auto_clean = true,
	compile_on_sync = true,
})

local utils = require("utils")

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim", event = "VimEnter" })
	use(utils.specs(require("plugins.commons")))

	use(utils.specs(require("plugins.lsp")))
	use(utils.specs(require("plugins.cmp")))

	use(utils.specs(require("plugins.ui")))
	use(utils.specs(require("plugins.misc")))
	use(utils.specs(require("plugins.tools")))
	use(utils.specs(require("plugins.telescope")))
	use(utils.specs(require("plugins.treesitter")))

	use({
		"sainnhe/sonokai",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		setup = function()
			-- Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
			-- Default value: `'default'`
			vim.g.sonokai_style = "shusia"
			-- Available values: `'auto'`, `'red'`, `'orange'`, `'yellow'`, `'green'`, `'blue'`, `'purple'`
			-- Default value: `'auto'`
			vim.g.sonokai_cursor = "red"
			if vim.nv.ui.italic then
				vim.g.sonokai_enable_italic = 1
				vim.g.sonokai_disable_italic_comment = 1
			end
			if vim.nv.ui.transparency then
				vim.g.sonokai_transparent_background = 1
			end
		end,
		config = function()
			vim.cmd([[colorscheme sonokai]])
		end,
	})
	-- {
	-- 	"NvChad/nvim-base16.lua",
	-- 	after = "packer.nvim",
	-- 	config = function()
	-- 		local base16 = require("base16")
	-- 		base16(base16.themes("gruvbox"), true)
	-- 	end,
	-- },
end)
