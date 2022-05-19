vim.cmd([[packadd packer.nvim]])

local ok, packer = pcall(require, "packer")
if not ok then
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
	vim.cmd([[packadd packer.nvim]])

	ok, packer = pcall(require, "packer")
	if ok then
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
		clone_timeout = 30, -- seconds
		default_url_format = "https://ghproxy.com/https://github.com/%s",
	},
	auto_clean = true,
	compile_on_sync = true,
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

return packer
