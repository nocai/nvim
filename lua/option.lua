vim.o.termguicolors = true

--Incremental live completion
vim.o.inccommand = 'nosplit'
vim.o.completeopt = 'menuone,noselect'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.cursorline = true
vim.o.colorcolumn = '88'

vim.o.clipboard = 'unnamedplus'
-- vim.o.list = true
vim.o.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'

vim.o.scrolloff      = 5
vim.o.sidescrolloff  = 5

vim.o.pumheight = 10

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.wo.foldenable = false
-- vim.wo.foldmethod = 'indent'
-- vim.wo.foldmethod = 'syntax'

