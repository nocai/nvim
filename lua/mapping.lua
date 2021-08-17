require("global")

--Remap space as leader key
vim.cmd([[let mapleader = "\<space>"]])

vim.api.nvim_set_keymap('n', '<leader>rc', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lf', ':luafile %<CR>', { noremap=true, silent=true })

----------------------------------------------------------------------------------------
-- New cursor movement (Colmark Layout)
--     ^
--     n
-- < h   i >
--     e
--     v

-- nN => jJ => eE => kK => nN
vim.api.nvim_set_keymap('n', 'n', 'j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'n', 'j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'N', 'J', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-n>', '<c-j>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', 'j', 'e', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'j', 'e', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'J', 'E', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-e>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', 'e', 'k', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'e', 'k', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'E', 'K', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-e>', '<c-k>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', 'k', 'n', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'k', 'n', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'K', 'N', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-n>', { noremap=true, silent=true })

-- iI => lL => iI
vim.api.nvim_set_keymap('n', 'l', 'i', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'l', 'i', { noremap=true, silent=true })
vim.api.nvim_set_keymap('o', 'l', 'i', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'L', 'I', { noremap=true, silent=true })
-- api.nvim_set_keymap('n', '<c-l>', '<c-i>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', 'i', 'l', { noremap=true, silent=true })
vim.api.nvim_set_keymap('x', 'i', 'l', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'I', 'L', { noremap=true, silent=true })
-- api.nvim_set_keymap('n', '<c-i>', '<c-l>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

vim.api.nvim_set_keymap('i', '<c-k>', '<c-n>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<c-e>', '<c-p>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<c-j>', '<c-e>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('t', '<m-n>', '<c-\\><c-n><c-w>j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-e>', '<c-\\><c-n><c-w>k', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-h>', '<c-\\><c-n><c-w>h', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<m-i>', '<c-\\><c-n><c-w>l', { noremap=true, silent=true })

-- 保存全部
vim.api.nvim_set_keymap('n', '<C-s>', ':wall<CR>', { noremap=true, silent=true })
