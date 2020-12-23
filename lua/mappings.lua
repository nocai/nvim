local api = vim.api

local mappings = {}

function mappings.setup()
  -- New cursor movement (Colmark Layout)
  --     ^
  --     n
  -- < h   i >
  --     e
  --     v

  -- vim.cmd('noremap n j')
  api.nvim_set_keymap('', 'n', 'j', { noremap=true, silent=true })
  -- vim.cmd('noremap N J')
  api.nvim_set_keymap('', 'N', 'J', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-n> 5j')
  api.nvim_set_keymap('', '<c-n>', '5j', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-w>n <c-w>j')
  api.nvim_set_keymap('', '<c-w>n', '<c-w>j', { noremap=true, silent=true })

  -- vim.cmd('noremap e k')
  api.nvim_set_keymap('', 'e', 'k', { noremap=true, silent=true })
  -- vim.cmd('noremap E K')
  api.nvim_set_keymap('', 'E', 'K', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-e> 5k')
  api.nvim_set_keymap('', '<c-e>', '5k', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-w>e <c-w>k')
  api.nvim_set_keymap('', '<c-w>e', '<c-w>k', { noremap=true, silent=true })

  -- vim.cmd('noremap i l')
  api.nvim_set_keymap('', 'i', 'l', { noremap=true, silent=true })
  -- vim.cmd('noremap I L')
  api.nvim_set_keymap('', 'I', 'L', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-w>i <c-w>l')
  api.nvim_set_keymap('', '<c-w>i', '<c-w>l', { noremap=true, silent=true })

  -- vim.cmd('noremap k n')
  api.nvim_set_keymap('', 'k', 'n', { noremap=true, silent=true })
  -- vim.cmd('noremap K N')
  api.nvim_set_keymap('', 'K', 'N', { noremap=true, silent=true })

  -- vim.cmd('noremap j e')
  api.nvim_set_keymap('', 'j', 'e', { noremap=true, silent=true })
  -- vim.cmd('noremap J E')
  api.nvim_set_keymap('', 'J', 'E', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-j> <c-e>')
  api.nvim_set_keymap('', '<c-j>', '<c-e>', { noremap=true, silent=true })

  -- vim.cmd('noremap u i')
  api.nvim_set_keymap('', 'u', 'i', { noremap=true, silent=true })
  -- vim.cmd('noremap U I')
  api.nvim_set_keymap('', 'U', 'I', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-u> <c-i>')
  api.nvim_set_keymap('', '<c-u>', '<c-i>', { noremap=true, silent=true })

  -- vim.cmd('noremap l u')
  api.nvim_set_keymap('', 'l', 'u', { noremap=true, silent=true })
  -- vim.cmd('noremap L U')
  api.nvim_set_keymap('', 'L', 'U', { noremap=true, silent=true })
  -- vim.cmd('noremap <c-l> <c-u>')
  api.nvim_set_keymap('', '<c-l>', '<c-u>', { noremap=true, silent=true })

  api.nvim_set_keymap('', 'Y', '"+y', { noremap=true })

  if require("global").is_vscode then
    api.nvim_exec(
      [[
      nnoremap rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>

      nnoremap gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
      nnoremap gT <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>

      nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
      nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>

      nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

      nnoremap <Leader>rr <Cmd>call VSCodeNotify('code-runner.run')<CR>

      nnoremap <leader>fr <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
      ]],
    false)
  end

end

return mappings
