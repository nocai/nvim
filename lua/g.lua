local vim = vim
vim.g.home = os.getenv("HOME")
vim.g.nvim_home = vim.g.home..'/.config/nvim'

--Remap space as leader key
vim.cmd([[let mapleader = "\<space>"]])

vim.api.nvim_set_keymap('', '<leader>rc', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>lf', ':luafile %<CR>', { noremap=true, silent=true })

----------------------------------------------------------------------------------------
-- New cursor movement (Colmark Layout)
--     ^
--     n
-- < h   i >
--     e
--     v

-- nN => jJ => eE => kK => nN
vim.api.nvim_set_keymap('', 'n', 'j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'N', 'J', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-n>', '<c-j>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

vim.api.nvim_set_keymap('', 'j', 'e', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'J', 'E', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-j>', '<c-e>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('', 'e', 'k', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'E', 'K', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-e>', '<c-k>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

vim.api.nvim_set_keymap('', 'k', 'n', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'K', 'N', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-k>', '<c-n>', { noremap=true, silent=true })

-- iI => lL => iI
vim.api.nvim_set_keymap('', 'l', 'i', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'L', 'I', { noremap=true, silent=true })
-- api.nvim_set_keymap('', '<c-l>', '<c-i>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('', 'i', 'l', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'I', 'L', { noremap=true, silent=true })
-- api.nvim_set_keymap('', '<c-i>', '<c-l>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

vim.api.nvim_set_keymap('i', '<c-k>', '<c-n>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<c-e>', '<c-p>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<c-j>', '<c-e>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('t', '<m-n>', '<c-\\><c-n><c-w>j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-e>', '<c-\\><c-n><c-w>k', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-h>', '<c-\\><c-n><c-w>h', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-i>', '<c-\\><c-n><c-w>l', { noremap=true, silent=true })

-- 保存全部
vim.api.nvim_set_keymap('', '<C-s>', ':wall<CR>', { noremap=true, silent=true })

----------------------------------------------------------------------------------------

-- Options
vim.o.termguicolors = true

--Incremental live completion
vim.o.inccommand = 'nosplit'
vim.o.completeopt = 'menuone,noselect,noinsert'

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
-- vim.o.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'

vim.o.scrolloff      = 5
vim.o.sidescrolloff  = 5

vim.o.pumheight = 10

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- vim.wo.foldenable = false
-- vim.wo.foldmethod = 'indent'
-- vim.wo.foldmethod = 'syntax'

----------------------------------------------------------------------------------------

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- 打开文件，光标回到上次编辑的位置
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

