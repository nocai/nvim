local vim = vim


-- New cursor movement (Colmark Layout)
--     ^
--     n
-- < h   i >
--     e
--     v

-- vim.cmd('noremap n j')
vim.api.nvim_set_keymap('', 'n', 'j', { noremap=true, silent=true })
-- vim.cmd('noremap N J')
vim.api.nvim_set_keymap('', 'N', 'J', { noremap=true, silent=true })
-- vim.cmd('noremap <c-n> 5j')
vim.api.nvim_set_keymap('', '<c-n>', '5j', { noremap=true, silent=true })
-- vim.cmd('noremap <c-w>n <c-w>j')
vim.api.nvim_set_keymap('', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

-- vim.cmd('noremap e k')
vim.api.nvim_set_keymap('', 'e', 'k', { noremap=true, silent=true })
-- vim.cmd('noremap E K')
vim.api.nvim_set_keymap('', 'E', 'K', { noremap=true, silent=true })
-- vim.cmd('noremap <c-e> 5k')
vim.api.nvim_set_keymap('', '<c-e>', '5k', { noremap=true, silent=true })
-- vim.cmd('noremap <c-w>e <c-w>k')
vim.api.nvim_set_keymap('', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

-- vim.cmd('noremap i l')
vim.api.nvim_set_keymap('', 'i', 'l', { noremap=true, silent=true })
-- vim.cmd('noremap I L')
vim.api.nvim_set_keymap('', 'I', 'L', { noremap=true, silent=true })
-- vim.cmd('noremap <c-w>i <c-w>l')
vim.api.nvim_set_keymap('', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

-- vim.cmd('noremap k n')
vim.api.nvim_set_keymap('', 'k', 'n', { noremap=true, silent=true })
-- vim.cmd('noremap K N')
vim.api.nvim_set_keymap('', 'K', 'N', { noremap=true, silent=true })

-- vim.cmd('noremap j e')
vim.api.nvim_set_keymap('', 'j', 'e', { noremap=true, silent=true })
-- vim.cmd('noremap J E')
vim.api.nvim_set_keymap('', 'J', 'E', { noremap=true, silent=true })
-- vim.cmd('noremap <c-j> <c-e>')
vim.api.nvim_set_keymap('', '<c-j>', '<c-e>', { noremap=true, silent=true })

-- vim.cmd('noremap u i')
vim.api.nvim_set_keymap('', 'u', 'i', { noremap=true, silent=true })
-- vim.cmd('noremap U I')
vim.api.nvim_set_keymap('', 'U', 'I', { noremap=true, silent=true })
-- vim.cmd('noremap <c-u> <c-i>')
vim.api.nvim_set_keymap('', '<c-u>', '<c-i>', { noremap=true, silent=true })

-- vim.cmd('noremap l u')
vim.api.nvim_set_keymap('', 'l', 'u', { noremap=true, silent=true })
-- vim.cmd('noremap L U')
vim.api.nvim_set_keymap('', 'L', 'U', { noremap=true, silent=true })
-- vim.cmd('noremap <c-l> <c-u>')
vim.api.nvim_set_keymap('', '<c-l>', '<c-u>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('', 'Y', '"+y', { noremap=true })