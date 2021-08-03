require("global")
require("mappings").setup()

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd([[autocmd BufWritePost init.lua PackerCompile]])

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tweekmonster/startuptime.vim'
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  -- use { 'jiangmiao/auto-pairs' }
	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	}
  -- use {
  --   'luochen1990/rainbow',
  --   config = function ()
  --       vim.g.rainbow_active = 1
  --   end,
  -- }


  use {
     'kana/vim-textobj-indent',
     requires = {'kana/vim-textobj-user'},
			config = function()
				vim.cmd([[
					let g:textobj_indent_no_default_key_mappings=1
					xmap ll <Plug>(textobj-indent-i)
					omap ll <Plug>(textobj-indent-i)
					xmap lL <Plug>(textobj-indent-same-i)
					omap lL <Plug>(textobj-indent-same-i)

					xmap al <Plug>(textobj-indent-a)
					omap al <Plug>(textobj-indent-a)
					xmap aL <Plug>(textobj-indent-same-a)
					omap aL <Plug>(textobj-indent-same-a)
				]])
			end
  }

  use {
     'sgur/vim-textobj-parameter',
     requires = { 'kana/vim-textobj-user' },
			config = function()
				vim.cmd([[
					let g:vim_textobj_parameter_mapping = 'a'
					xmap la <Plug>(textobj-parameter-i)
					omap la <Plug>(textobj-parameter-i)
					xmap aa <Plug>(textobj-parameter-a)
					omap aa <Plug>(textobj-parameter-a)
				]])
			end
  }

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use {
     'kyazdani42/nvim-tree.lua',
     requires = { 'kyazdani42/nvim-web-devicons' },
     config = function ()
         vim.g.nvim_tree_auto_close = 1
         vim.g.nvim_tree_auto_open = 1
         -- vim.g.nvim_tree_quit_on_open = 1
				 vim.g.nvim_tree_highlight_opened_files = 3
         vim.g.nvim_tree_follow = 1
         vim.g.nvim_tree_width_allow_resize  = 1
         vim.g.nvim_tree_special_files = { Makefile= 1, AKEFILE= 1 }
         vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }

         vim.api.nvim_set_keymap('n', 'ff', ':NvimTreeFindFile<CR>', { noremap=true, silent=true })
         vim.api.nvim_set_keymap('n', 'q', ':NvimTreeClose<CR>', { noremap=true, silent=true })
     end,
  }
  use {
   'voldikss/vim-floaterm',
   config = function ()
     vim.cmd([[
       hi FloatermBorder guifg=gray
       let g:floaterm_width=0.8
       let g:floaterm_height=0.8
       let g:floaterm_keymap_new    = '<F7>'
       let g:floaterm_keymap_prev   = '<F8>'
       let g:floaterm_keymap_next   = '<F9>'
       let g:floaterm_keymap_toggle = '<C-T>'
     ]])
   end
  }
	use {
		'szw/vim-maximizer',
		config = function()
			vim.g.maximizer_default_mapping_key = '<C-w>z'
		end
	}

	use {
		"npxbr/glow.nvim",
		run = "GlowInstall",
		config = function()
			vim.cmd([[ noremap <leader>gl :Glow<CR> ]])
		end
	}

  -- UI to select things (files, grep results, open buffers...)
  use {
   'nvim-telescope/telescope.nvim',
   requires = {
		 { 'nvim-lua/popup.nvim' },
		 { 'nvim-lua/plenary.nvim' },
			-- Automatic tags management
		 { 'ludovicchabant/vim-gutentags'},
	 },
   config = function ()
     -- Telescope
	  local actions = require "telescope.actions"
     require('telescope').setup {
       defaults = {
					selection_strategy = "closest",
         mappings = {
           i = {
             ["<C-k>"] = false,
             ["<C-e>"] = false,
             ["<C-k>"] = actions.move_selection_next,
             ["<C-e>"] = actions.move_selection_previous,
             ["<C-l>"] = false,
             ["<C-i>"] = actions.complete_tag,
           },
           n = {
             ["j"] = false,
             ["k"] = false,
             ["L"] = false,
             ["n"] = actions.move_selection_next,
             ["k"] = actions.move_selection_next,
             ["p"] = actions.move_selection_previous,
             ["e"] = actions.move_selection_previous,
             ["I"] = actions.move_to_bottom,
           },
         },
       },
     }
     --Add leader shortcuts
     vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewers = true})<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>f/', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>f?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
   end
  }
  --use {
  -- 'itchyny/lightline.vim',  -- Fancier statusline
		---- require = 'monsonjeremy/onedark.nvim',
  -- config = function()
		 ----Set statusbar
		 --vim.g.lightline = {
			 --colorscheme = 'onedark',
			 --active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
			 --component_function = { gitbranch = 'fugitive#head' },
		 --}
  -- end,
  --}
	-- use {
	-- 	'glepnir/galaxyline.nvim',
	--   requires = 'kyazdani42/nvim-web-devicons',
	-- 	config = function()
	-- 		-- require('internal/eviline')
	-- 	end
	-- }
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons'},
		config = function()
			require('lualine').setup{
				options = {
					theme = 'onedark',
					section_separators = '', component_separators = '',
				},
				extensions = {'nvim-tree'},
			}
		end
	}

  use {
	  'akinsho/nvim-bufferline.lua',
	  requires = 'kyazdani42/nvim-web-devicons',
	  config = function ()
			require("bufferline").setup{
				options = {
					offsets = {{filetype = "NvimTree", text = "Press g? for help", text_align = "left"}}
				}
			}
	  end
  }
  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
      -- Gitsigns
      require('gitsigns').setup {
        current_line_blame = true,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end
  }

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      -- Treesitter configuration
      -- Parsers must be installed manually via :TSInstall
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true, -- false will disable the whole extension
					additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = {
          enable = true,
        },
      }
    end
  }

	use {
		'p00f/nvim-ts-rainbow',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require'nvim-treesitter.configs'.setup {
				rainbow = {
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
					colors = {}, -- table of hex strings
					termcolors = {} -- table of colour name strings
				}
			}
		end
	}
	use {
		'windwp/nvim-ts-autotag',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('nvim-ts-autotag').setup()
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
							['af'] = '@function.outer',
              ['lf'] = '@function.inner',

              ['ac'] = '@class.outer',
              ['lc'] = '@class.inner',

							['li'] = '@conditional.inner',
							['ai'] = '@conditional.outer',
            },
          },
        },
			}
		end
	}

  use {
      'thinca/vim-quickrun',
      -- keys = { '<leader>rr' },
      config = function ()
          vim.g.quickrun_no_default_key_mappings = 1
          vim.g.quickrun_config = { _ = { outputter = "message" }}
          vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>(quickrun)', { noremap=false, silent=false })
      end,
  }
  use {
	  'vim-test/vim-test',
	  config = function ()
      vim.cmd([[
        nmap <silent> <leader>tn :TestNearest -v<CR>
        nmap <silent> <leader>tf :TestFile -v<CR>
        nmap <silent> <leader>ts :TestSuite -v <CR>
        nmap <silent> <leader>tl :TestLast -v<CR>
        nmap <silent> <leader>tv :TestVisit<CR>
      ]])
	  end
  }
  use {
    'sebdah/vim-delve',
    config = function ()
      vim.cmd([[
        nmap <leader>dd :DlvDebug<CR>
        nmap <leader>dt :DlvTest<CR>
        nmap <leader>db :DlvToggleBreakpoint<CR>
      ]])
    end
  }

  -- use {
  --   'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  --   config = function ()
  --     local nvim_lsp = require('lspconfig')

  --     -- Use an on_attach function to only map the following keys
  --     -- after the language server attaches to the current buffer
  --     local on_attach = function(client, bufnr)
  --       local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --       local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --       --Enable completion triggered by <c-x><c-o>
  --       buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  --       -- Mappings.
  --       local opts = { noremap=true, silent=true }

  --       -- See `:help vim.lsp.*` for documentation on any of the below functions
  --       buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --       buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --       buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --       buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --       -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --       -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --       -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --       -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --       buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --       buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  --       buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --       buf_set_keymap('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  --       -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --       buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --       buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --       -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --       -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  --       vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  --     end

  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities.textDocument.completion.completionItem.snippetSupport = true

  --     nvim_lsp.gopls.setup {
  --       cmd = {"gopls","--remote=auto"},
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --       init_options = {
  --         usePlaceholders=true,
  --         completeUnimported=true,
  --       }
  --     }
  --   end
  -- }

  -- use {
  --   'hrsh7th/nvim-compe', -- Autocompletion plugin
  --   config = function ()
  --     -- Set completeopt to have a better completion experience
  --     vim.o.completeopt = 'menuone,noselect'

  --     -- Compe setup
  --     require('compe').setup {
  --       source = {
  --         path = true,
  --         nvim_lsp = true,
  --         buffer = true,
  --         calc = false,
  --         nvim_lua = false,
  --         vsnip = false,
  --         ultisnips = false,
  --       },
  --     }

  --     -- Utility functions for compe and luasnip
  --     local t = function(str)
  --       return vim.api.nvim_replace_termcodes(str, true, true, true)
  --     end

  --     local check_back_space = function()
  --       local col = vim.fn.col '.' - 1
  --       if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
  --         return true
  --       else
  --         return false
  --       end
  --     end

  --     -- Use (s-)tab to:
  --     --- move to prev/next item in completion menuone
  --     --- jump to prev/next snippet's placeholder
  --     _G.tab_complete = function()
  --       if vim.fn.pumvisible() == 1 then
  --         return t '<C-n>'
  --       elseif check_back_space() then
  --         return t '<Tab>'
  --       else
  --         return vim.fn['compe#complete']()
  --       end
  --     end

  --     _G.s_tab_complete = function()
  --       if vim.fn.pumvisible() == 1 then
  --         return t '<C-p>'
  --       else
  --         return t '<S-Tab>'
  --       end
  --     end

  --     -- Map tab to the above tab complete functiones
  --     vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  --     vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  --     vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  --     vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

  --     -- Map compe confirm and complete functions
  --     vim.api.nvim_set_keymap('i', '<cr>', "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
  --     vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
  --   end
  -- }


  use {
    'neoclide/coc.nvim',
		requires = {
			{ 'honza/vim-snippets' },
			{ 'preservim/tagbar' },
		},
    branch = 'release',
    config = function ()
      vim.cmd([[
        let g:coc_snippet_next = '<C-n>'
        let g:coc_snippet_prev = '<C-e>'
        let g:snips_author = 'bucai'
        let g:coc_global_extensions =[ 'coc-marketplace', 'coc-snippets', 'coc-translator','coc-json', 'coc-lists', 'coc-actions', 'coc-vimlsp', 'coc-vetur', 'coc-emmet', 'coc-prettier', 'coc-diagnostic' ]

        autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

        inoremap <silent><expr><TAB> v:lua.is_pairs() ? "<Right>" : pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()
        inoremap <silent><expr><S-TAB> v:lua.is_pairs(v:true) ? "<Left>" : pumvisible() ? "<C-p>" : "<S-TAB>"

        inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"

        nmap <silent>[g <Plug>(coc-diagnostic-prev)
        nmap <silent>]g <Plug>(coc-diagnostic-next)

        nmap <silent>gd <Plug>(coc-definition)
        nmap <silent>gD <Plug>(coc-declaration)
        nmap <silent>gy <Plug>(coc-type-definition)
        nmap <silent>gi <Plug>(coc-implementation)
        nmap <silent>gr <Plug>(coc-references)
        nmap <silent>rn <Plug>(coc-rename)

        nmap <silent><leader>fc <Plug>(coc-fix-current)
        nmap <silent><leader>rf <Plug>(coc-refactor)

        nmap <silent><leader>ac <Plug>(coc-codeaction)

        nnoremap <silent><leader><leader>l :<C-u>CocList<cr>
        nnoremap <silent><leader><leader>a :<C-u>CocList diagnostics<cr>
        nnoremap <silent><leader><leader>o :<C-u>CocList outline<cr>
        " nnoremap <silent><leader><leader>s :<C-u>CocList -I symbols<cr>
        nnoremap <silent><leader><leader>n :<C-u>CocNext<CR>
        nnoremap <silent><leader><leader>p :<C-u>CocPrev<CR>
        nnoremap <silent><leader><leader>r :<C-u>CocListResume<CR>

				" Use K to show documentation in preview window
        nnoremap <silent>E :call CocActionAsync('doHover')<CR>

				nmap <Leader>tr <Plug>(coc-translator-p)
				vmap <Leader>tr <Plug>(coc-translator-pv)

				" Remap <C-f> and <C-b> for scroll float windows/popups.
				if has('nvim-0.4.0') || has('patch-8.2.0750')
					nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
					nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
					inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
					inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
					vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
					vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
				endif

				nmap <leader><leader>t :TagbarToggle<CR>
      ]])
    end
  }

	-- use {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	config = function()
	-- 		vim.g.indent_blankline_char = '┊'
	-- 		vim.g.indent_blankline_filetype_exclude = { 'help', 'packer', 'nvimtree' }
	-- 		vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
	-- 		vim.g.indent_blankline_char_highlight = 'LineNr'
	-- 		vim.g.indent_blankline_show_trailing_blankline_indent = false
	-- 	end
  -- }

  --use {
  --  'joshdick/onedark.vim', -- Theme inspired by Atom
  --  config = function ()
  --    --Set colorscheme (order is important here)
  --    vim.o.termguicolors = true
  --    vim.cmd [[colorscheme onedark]]
  --  end
  --}

	use {
		'navarasu/onedark.nvim',
		config = function()
			vim.cmd [[ colorscheme onedark ]]
		end
	}
end)


--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.api.nvim_set_keymap('', '<leader>rc', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- ---- 打开文件，光标回到上次编辑的位置
vim.cmd([[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

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

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
