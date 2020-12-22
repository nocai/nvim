require("test")

local global = require("global")

require("options")
require("mappings")

vim.cmd("autocmd BufWritePost init.lua PackerCompile")

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require'colorizer'.setup()
        end,
        cond = function() return false end
    }

    use {
      'cespare/vim-toml',
      ft = { 'toml' }
    }

    -- use 'euclidianAce/BetterLua.vim'

    -- use 'yggdroot/indentLine'

    use { 
      'thinca/vim-quickrun',
      keys = { '<leader>rr' },
      config = function ()
        vim.g.quickrun_no_default_key_mappings = 1
        vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>(quickrun)', { noremap=false, silent=false })
        vim.api.nvim_exec(
          [[
            let g:quickrun_config = { "_" : { "outputter" : "message" }}
          ]],
        false)
      end
    }

    use {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() require('galaxyline/eviline') end,
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- use {
    --   'datwaft/bubbly.nvim',
    --   config = function()
    --     vim.g.bubbly_palette = {
    --       background = "#34343c",
    --       foreground = "#c5cdd9",
    --       black = "#3e4249",
    --       red = "#ec7279",
    --       green = "#a0c980",
    --       yellow = "#deb974",
    --       blue = "#6cb6eb",
    --       purple = "#d38aea",
    --       cyan = "#5dbbc1",
    --       white = "#c5cdd9",
    --       lightgrey = "#57595e",
    --       darkgrey = "#404247",
    --     }
    --   end
    -- }

    use {
      'morhetz/gruvbox',
      config = function ()
        -- vim.cmd("set background=dark")
        vim.cmd("colorscheme gruvbox")
      end
    }
    
    -- use {
    --   "npxbr/gruvbox.nvim", 
    --   requires = {"tjdevries/colorbuddy.vim"},
    --   config = require("colorbuddy").colorscheme("gruvbox")
    -- }

    use {
      'luochen1990/rainbow',
      event = {'BufReadPre *', 'BufNewFile *'},
      config = function ()
        vim.g.rainbow_active = 1
      end
    }

    use {
      'jiangmiao/auto-pairs',
      event = {'BufReadPre *', 'BufNewFile *'}
    }

    use { 
      'tpope/vim-commentary',
      keys = { 'gcc', 'gc' }
    }

    use { 'kana/vim-textobj-user' }

    use { 
      'kana/vim-textobj-indent',
      requires = {'kana/vim-textobj-user'},
      config = function ()
        vim.g.textobj_indent_no_default_key_mappings = 1

        vim.api.nvim_set_keymap('x', 'uu', '<Plug>(textobj-indent-i)', {})
        vim.api.nvim_set_keymap('o', 'uu', '<Plug>(textobj-indent-i)', {})

        vim.api.nvim_set_keymap('x', 'uU', '<Plug>(textobj-same-i)', {})
        vim.api.nvim_set_keymap('o', 'uU', '<Plug>(textobj-same-i)', {})

        vim.api.nvim_set_keymap('x', 'au', '<Plug>(textobj-indent-a)', {})
        vim.api.nvim_set_keymap('o', 'au', '<Plug>(textobj-indent-a)', {})

        vim.api.nvim_set_keymap('x', 'aU', '<Plug>(textobj-same-a)', {})
        vim.api.nvim_set_keymap('o', 'aU', '<Plug>(textobj-same-a)', {})
      end
    }

    use {
      'sgur/vim-textobj-parameter',
      requires = { 'kana/vim-textobj-user' },
      config = function ()
        vim.g.textobj_parameter_no_default_key_mappings = 1

        vim.api.nvim_set_keymap('x', 'u,', '<Plug>(textobj-parameter-i)', {})
        vim.api.nvim_set_keymap('o', 'u,', '<Plug>(textobj-parameter-i)', {})

        vim.api.nvim_set_keymap('x', 'a,', '<Plug>(textobj-parameter-a)', {})
        vim.api.nvim_set_keymap('o', 'a,', '<Plug>(textobj-parameter-a)', {})
      end
    }

    use {
      'kdheepak/lazygit.nvim',
      keys = { '<leader>gg' },
      config = function ()
        vim.g.lazygit_floating_window_winblend = 0
        vim.g.lazygit_floating_window_scaling_factor = 0.9
        vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', { noremap=true, silent=true })
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      -- keys = { 'tt' },
      -- cmd = { 'LuaTreeToggle' },
      config = function ()
        vim.api.nvim_set_keymap('n', 'tt', ':LuaTreeToggle<CR>', { noremap=true, silent=true })
        vim.api.nvim_set_keymap('n', 'q', ':LuaTreeClose<CR>', { noremap=true, silent=true })
        -- vim.api.nvim_buf_set_keymap('0', 'n', 'q', ':LuaTreeClose<CR>', { noremap=true, silent=true })
      end
    }

    use {
      'tpope/vim-surround',
      event = { 'BufReadPre *', 'BufNewFile *'}
    }

    use {
      'Yggdroot/LeaderF',
      keys = { '<leader>ff', '<leader>fb', '<leader>fm', '<leader>fl', '<leader>fr' },
      config = function()
        -- vim.g.Lf_ShortcutF = '<leader>ff'
        vim.api.nvim_exec(
          [[
            let g:Lf_CommandMap = {'<c-k>': ['<c-e>'], '<c-j>': ['<c-n>']}

            let g:Lf_WindowPosition = 'popup'
            let g:Lf_PreviewInPopup = 1
            let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
            let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

            noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
            noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
            noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
            noremap <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
          ]],
        false)
      end
    }
    vim.api.nvim_exec(
      [[
        let g:Lf_ShortcutF = '<leader>ff'
      ]],
    false)

    use {
      'neoclide/coc.nvim',
      event = { 'BufReadPre *', 'BufNewFile *'},
        config = function ()
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
        end
      }
end)
