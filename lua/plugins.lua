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

	-- {
	-- 	"NvChad/nvim-base16.lua",
	-- 	after = "packer.nvim",
	-- 	config = function()
	-- 		local base16 = require("base16")
	-- 		base16(base16.themes("gruvbox"), true)
	-- 	end,
	-- },
end)
