local vim, api = vim, vim.api

local mappings = {}

function mappings.setup()
  vim.api.nvim_exec([[let mapleader = "\<space>"]], false)
  api.nvim_set_keymap('', '<leader>lf', ':luafile %<CR>', { noremap=true, silent=true })

  -- New cursor movement (Colmark Layout)
  --     ^
  --     n
  -- < h   i >
  --     e
  --     v

  -- nN => jJ => eE => kK => nN
  api.nvim_set_keymap('', 'n', 'j', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'N', 'J', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-n>', '<c-j>', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'j', 'e', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'J', 'E', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-j>', '<c-e>', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'e', 'k', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'E', 'K', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-e>', '<c-k>', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'k', 'n', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'K', 'N', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-k>', '<c-n>', { noremap=true, silent=true })

  -- iI => lL => iI
  api.nvim_set_keymap('', 'l', 'i', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'L', 'I', { noremap=true, silent=true })
  -- api.nvim_set_keymap('', '<c-l>', '<c-i>', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'i', 'l', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'I', 'L', { noremap=true, silent=true })
  -- api.nvim_set_keymap('', '<c-i>', '<c-l>', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

  api.nvim_set_keymap('i', '<c-k>', '<c-n>', { noremap=true, silent=true })
  api.nvim_set_keymap('i', '<c-e>', '<c-p>', { noremap=true, silent=true })
  api.nvim_set_keymap('i', '<c-j>', '<c-e>', { noremap=true, silent=true })

  -- api.nvim_set_keymap('t', '<c-w>n', '<c-\\><c-n><c-w>j', { noremap=true, silent=true })
  -- api.nvim_set_keymap('t', '<c-w>e', '<c-\\><c-n><c-w>k', { noremap=true, silent=true })
  -- api.nvim_set_keymap('t', '<c-w>h', '<c-\\><c-n><c-w>h', { noremap=true, silent=true })
  -- api.nvim_set_keymap('t', '<c-w>i', '<c-\\><c-n><c-w>l', { noremap=true, silent=true })

  -- buffer切换
  -- api.nvim_set_keymap('', '<C-k>', ':bn<CR>', { noremap=true, silent=true })
  -- api.nvim_set_keymap('', '<C-p>', ':bp<CR>', { noremap=true, silent=true })
  -- 保存全部
  api.nvim_set_keymap('', '<C-s>', ':wall<CR>', { noremap=true, silent=true })


  -- 不知道为什么，nvim不生效。但vim可以
  -- api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap=true, silent=true })
  -- api.nvim_set_keymap('i', '<C-i>', '<Right>', { noremap=true, silent=true })
end

return mappings
