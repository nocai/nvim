local vim, api = vim, vim.api

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  -- rewrite options
  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local mappings = {}

function mappings.setup()
  -- New cursor movement (Colmark Layout)
  --     ^
  --     n
  -- < h   i >
  --     e
  --     v

  -- nN => jJ => eE => kK => nN
  api.nvim_set_keymap('', 'n', 'j', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'N', 'J', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'j', 'e', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'J', 'E', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-j>', '<c-e>', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'e', 'k', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'E', 'K', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'k', 'n', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'K', 'N', { noremap=true, silent=true })

  -- iI => lL => iI
  api.nvim_set_keymap('', 'l', 'i', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'L', 'I', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>l', '<c-w>i', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'i', 'l', { noremap=true, silent=true })
  api.nvim_set_keymap('', 'I', 'L', { noremap=true, silent=true })
  api.nvim_set_keymap('', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

  -- api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap=true, silent=true })
  -- api.nvim_set_keymap('i', '<C-i>', '<Right>', { noremap=true, silent=true })

  if vim.g.is_not_vscode then
    vim.api.nvim_exec([[let mapleader = "\<space>"]], false)
    api.nvim_set_keymap('', '<leader>lf', ':luafile %<CR>', { noremap=true, silent=true })
  else
    api.nvim_exec(
      [[
        nnoremap rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>

        nnoremap gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
        nnoremap gY <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>

        nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
        nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>

        nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine

		nnoremap <C-w>n <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
		xnoremap <C-w>n <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>

		nnoremap <C-w>e <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
		xnoremap <C-w>e <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>

		nnoremap <C-w>i <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
		xnoremap <C-w>i <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
      ]],
    false)
  end

  -- buffer
  map('n', '<Leader>bp', '<cmd>bprevious<CR>')
  map('n', '<Leader>bn', '<cmd>bnext<CR>')
  map('n', '<Leader>bf', '<cmd>bfirst<CR>')
  map('n', '<Leader>bl', '<cmd>blast<CR>')
  map('n', '<Leader>bd', '<cmd>bdelete<CR>')
end

return mappings
