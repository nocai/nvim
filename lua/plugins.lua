local ok, _ = pcall(vim.cmd, "packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present or not ok then
	print("Cloning packer...")
	-- remove the dir before cloning
	vim.fn.delete(vim.nv.packer_path, "rf")
	vim.fn.system({
		"git",
		"clone",
		"https://ghproxy.com/https://github.com/wbthomason/packer.nvim",
		"--depth",
		"20",
		vim.nv.packer_path,
	})

	vim.cmd("packadd packer.nvim")
	present, packer = pcall(require, "packer")

	if present then
		print("Packer cloned successfully.")
	else
		error("Couldn't clone packer !\nPacker path: " .. vim.nv.packer_path .. "\n" .. packer)
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

return packer.startup(function(use)
	use({
		{ "nvim-lua/plenary.nvim", disable = vim.nv.is_vscode },
		{ "nathom/filetype.nvim", disable = vim.nv.is_vscode },
		{ "nanotee/nvim-lua-guide", disable = vim.nv.is_vscode },
		{ "wbthomason/packer.nvim", event = "VimEnter" },
		{
			"kyazdani42/nvim-web-devicons",
			event = "VimEnter",
			disable = vim.nv.is_vscode,
			config = function()
				require("colors").devicons()
			end,
		},
		-- {
		--   "NvChad/nvim-base16.lua",
		--   after = "packer.nvim",
		--   config = function()
		--     require("colors").init(vim.nv.ui.theme)
		--   end
		-- }
	})

	use(require("plugins.misc"))
	use(require("plugins.ui"))
	use(require("plugins.cmp"))
	use(require("plugins.lspconfig"))
	use(require("plugins.telescope"))
	use(require("plugins.tools"))
	use(require("plugins.treesitter"))
	use(require("plugins.themes"))
end)
