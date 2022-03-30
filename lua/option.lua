vim.o.termguicolors = true
vim.o.showmode = false

--Incremental live completion
vim.o.inccommand = "nosplit"
vim.o.completeopt = "menu,menuone,noinsert"

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd([[set undofile]])
-- no swap files
vim.cmd([[set noswapfile]])

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

vim.o.cursorline = true
-- vim.o.colorcolumn = "88"

vim.o.clipboard = "unnamedplus"
-- vim.o.list = true
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"

vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

vim.o.pumheight = 10

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.wo.foldenable = false
-- vim.wo.foldmethod = 'indent'
-- vim.wo.foldmethod = 'syntax'

-- disable nvim intro
vim.opt.shortmess:append("sI")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")
