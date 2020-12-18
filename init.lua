local vim = vim

vim.cmd('let mapleader=" "')

-- New cursor movement (Colmark Layout)
--     ^
--     n
-- < h   i >
--     e
--     v

-- vim.api.nvim_set_keymap('n', '<leader><Space>', ':set hlsearch<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <leader><Space> :set hlsearch<CR>

-- vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'

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



require("nocai.gfunc")
require("global")
require('options').load()

vim.cmd("autocmd BufWritePost init.lua PackerCompile")

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require('eviline') end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
        'morhetz/gruvbox',
    }
    vim.cmd("colorscheme gruvbox")
    vim.cmd("set background=dark")

    use {
        'luochen1990/rainbow'
    }
    vim.cmd("let g:rainbow_active = 1")

    use {
        'jiangmiao/auto-pairs',
        event = {'BufReadPre *', 'BufNewFile *'}
    }

    use { 'tpope/vim-commentary' }

    use { 'kana/vim-textobj-user' }

    use { 'kana/vim-textobj-indent', requires = {'kana/vim-textobj-user'} }
    vim.cmd(
      [[
        let g:textobj_indent_no_default_key_mappings=1

        xmap uu <Plug>(textobj-indent-i)
        omap uu <Plug>(textobj-indent-i)
        xmap uU <Plug>(textobj-indent-same-i)
        omap uU <Plug>(textobj-indent-same-i)

        xmap au <Plug>(textobj-indent-a)
        omap au <Plug>(textobj-indent-a)
        xmap aU <Plug>(textobj-indent-same-a)
        omap aU <Plug>(textobj-indent-same-a)
      ]]
    )

    use {
      'sgur/vim-textobj-parameter',
      requires = { 'kana/vim-textobj-user' }
    }
    vim.cmd(
      [[
        let g:textobj_parameter_no_default_key_mappings=1

        xmap ua <Plug>(textobj-parameter-i)
        omap ua <Plug>(textobj-parameter-i)
        xmap aa <Plug>(textobj-parameter-a)
        omap aa <Plug>(textobj-parameter-a)
      ]]
    )

    use {
      'kdheepak/lazygit.nvim',
      cmd = { 'LazyGit' },
    }
    vim.cmd(
      [[
        nnoremap <silent> <leader>gg :LazyGit<CR>
        let g:lazygit_floating_window_winblend = 0
        let g:lazygit_floating_window_scaling_factor = 0.9
      ]]
    )

    use {
      'kyazdani42/nvim-tree.lua'
    }
    vim.cmd("nnoremap tt :LuaTreeToggle<CR>")

    use {
      'neoclide/coc.nvim'
    }

    vim.api.nvim_exec(
      [[
        let g:coc_snippet_next = '<TAB>'
        let g:coc_snippet_prev = '<S-TAB>'
        let g:snips_author = 'bucai'
        let g:coc_global_extensions =[ 'coc-marketplace', 'coc-pairs', 'coc-snippets', 'coc-json', 'coc-lists', 'coc-stylelint', 'coc-yaml', 'coc-actions', 'coc-vimlsp', 'coc-vetur', 'coc-emmet', 'coc-prettier', 'coc-diagnostic' ]

        autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

        
        inoremap <silent><expr> <TAB> pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "<C-p>" : "<C-h>"

        inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
        inoremap <expr><C-e> pumvisible() ? "<C-p>" : "<C-e>"
        
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gt <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        nmap <silent>rn <Plug>(coc-rename)
        nmap <silent>ca <Plug>(coc-codeaction)
        nmap <silent>fc <Plug>(coc-fix-current)

        nnoremap <silent> <leader><leader>l  :<C-u>CocList<cr>
        nnoremap <silent> <leader><leader>a  :<C-u>CocList diagnostics<cr>
        nnoremap <silent> <leader><leader>e  :<C-u>CocList extensions<cr>
        nnoremap <silent> <leader><leader>c  :<C-u>CocList commands<cr>
        nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>
        nnoremap <silent> <leader><leader>s  :<C-u>CocList -I symbols<cr>
        nnoremap <silent> <leader><leader>n  :<C-u>CocNext<CR>
        nnoremap <silent> <leader><leader>p  :<C-u>CocPrev<CR>
        nnoremap <silent> <leader><leader>r  :<C-u>CocListResume<CR>

        nnoremap <silent> K :call CocAction('doHover')<CR>

        xmap uf <Plug>(coc-funcobj-i)
        omap uf <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap af <Plug>(coc-funcobj-a) 
      ]],
    false)
end)
