vim.g.mapleader = " "

-- vim.opt.laststatus = 3 -- global statusline

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
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- vim.g.did_load_filetypes = 1
-- use filetype.lua instead of filetype.vim
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- disable ruby
vim.g.loaded_ruby_provider = 0
-- disable perl
vim.g.loaded_perl_provider = 0
