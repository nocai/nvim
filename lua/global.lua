vim.g.home = os.getenv("HOME")
vim.g.nvim_home = vim.g.home..'/.config/nvim'
vim.g.is_macOS = jit.os == "OSX"
vim.g.is_linux = jit.os == "Linux"
