require('global')
require('option')
require('autocmd')
-- vim.lsp.set_log_level("debug")

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd([[autocmd BufWritePost init.lua PackerCompile]])

local use = require('packer').use
require('packer').startup(function()

use { 'wbthomason/packer.nvim' } -- Package manager

-- misc
use {
	-- { "tpope/vim-surround" },
	-- { 'tpope/vim-repeat' },
	{ 'jiangmiao/auto-pairs' },
	{ 'tweekmonster/startuptime.vim', cmd = {'StartupTime'} },
	{ 'npxbr/glow.nvim', run = "GlowInstall", cmd = 'Glow', },
	{ 'voldikss/vim-translator', cmd = { 'TranslateW' }, },
	{'karb94/neoscroll.nvim', event = "WinScrolled", config = function () require('neoscroll').setup() end },
	{ 'machakann/vim-sandwich',
		config = function ()
			vim.g.textobj_sandwich_no_default_key_mappings = 1
			vim.cmd([[
				silent! omap <unique> lb <Plug>(textobj-sandwich-auto-i)
				silent! xmap <unique> lb <Plug>(textobj-sandwich-auto-i)
				silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
				silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

				silent! omap <unique> ls <Plug>(textobj-sandwich-query-i)
				silent! xmap <unique> ls <Plug>(textobj-sandwich-query-i)
				silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
				silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
			]])
		end
	},
	{'voldikss/vim-floaterm',
		config = function ()
			vim.cmd([[
				 hi FloatermBorder guifg=gray
				 let g:floaterm_width=0.8
				 let g:floaterm_height=0.8
				 let g:floaterm_keymap_new    = '<F7>'
				 let g:floaterm_keymap_prev   = '<F8>'
				 let g:floaterm_keymap_next   = '<F9>'
				 let g:floaterm_keymap_toggle = '<F12>'
				 nnoremap <silent> <M-t> :FloatermToggle<CR>
				 tnoremap <silent> <M-t> <C-\><C-n>:FloatermToggle<CR>
			 ]])
		 end
	},
}

-- textobject
use {
	{'kana/vim-textobj-user'},
-- 		{'kana/vim-textobj-indent',
-- 			requires = {'kana/vim-textobj-user'},
-- 			config = function()
-- 				vim.cmd([[
-- 					let g:textobj_indent_no_default_key_mappings=1
-- 					xmap ll <Plug>(textobj-indent-i)
-- 					omap ll <Plug>(textobj-indent-i)
-- 					xmap lL <Plug>(textobj-indent-same-i)
-- 					omap lL <Plug>(textobj-indent-same-i)

-- 					xmap al <Plug>(textobj-indent-a)
-- 					omap al <Plug>(textobj-indent-a)
-- 					xmap aL <Plug>(textobj-indent-same-a)
-- 					omap aL <Plug>(textobj-indent-same-a)
-- 				]])
-- 			end
-- 		},
	{'sgur/vim-textobj-parameter',
		requires = { 'kana/vim-textobj-user' },
		config = function()
			vim.cmd([[
				let g:textobj_parameter_no_default_key_mappings=1
				xmap la <Plug>(textobj-parameter-i)
				omap la <Plug>(textobj-parameter-i)
				xmap aa <Plug>(textobj-parameter-a)
				omap aa <Plug>(textobj-parameter-a)
			]])
		end
	},
}

-- telescope
use {
	{'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/popup.nvim' }, {'nvim-lua/plenary.nvim' }, },
		config = function ()
			local actions = require "telescope.actions"
			require('telescope').setup {
				defaults = {
					prompt_prefix='🔍',
					previewers = true,
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

			vim.api.nvim_set_keymap('n', '<c-p>p', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p><c-p>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<c-p>g', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p><c-g>', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<c-p>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p><c-b>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<c-p>h', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true })
			vim.api.nvim_set_keymap('n', '<c-p><c-h>', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true })

			vim.api.nvim_set_keymap('n', '<c-p>gs', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p>gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p>gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p>wd', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]], { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<c-p>wD', [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]], { noremap = true, silent = true })
		end
	},
	{'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
		config = function()
			require('telescope').setup {
				extensions = {
					fzf = {
						fuzzy = true,                    -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = false,     -- override the file sorter
						case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
					}
				}
			}
			require('telescope').load_extension('fzf')
		end
	}
}

-- git
use {
	{'tpope/vim-fugitive', cmd = 'G'},
	{'lewis6991/gitsigns.nvim',
		requires = {'nvim-lua/plenary.nvim'},
		config = function()
			require('gitsigns').setup {
				current_line_blame = true,
				signs = {
					add = {text = '+'},
					change = {text = '~'},
					delete = {text = '_'},
					topdelete = {text = '‾'},
					changedelete = {text = '~'},
				},
				keymaps = {
					noremap = true,

					['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
					['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

					['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
					['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
					['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
					['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
					['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
					['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
					['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
					['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
					-- Text objects
					['o lh'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
					['x lh'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
				}
			}
		end
	}
}

-- treesitter
use {
	{'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate',
		config = function ()
			-- :TSInstall
			require('nvim-treesitter.configs').setup {
				indent = { enable = true },
				highlight = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = 'gnn',
						node_incremental = 'grn',
						scope_incremental = 'grc',
						node_decremental = 'grm',
					},
				},
			}
			-- vim.api.nvim_command('set foldmethod=expr')
			-- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
		end
	},
	{'p00f/nvim-ts-rainbow',
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
	},
	{'windwp/nvim-ts-autotag',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('nvim-ts-autotag').setup()
		end
	},
	{'nvim-treesitter/nvim-treesitter-textobjects',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('nvim-treesitter.configs').setup {
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							['lf'] = '@function.inner',
							['af'] = '@function.outer',
							['lc'] = '@class.inner',
							['ac'] = '@class.outer',

							['ll'] = '@loop.inner',
							['al'] = '@loop.outer',

							['li'] = '@conditional.inner',
							['ai'] = '@conditional.outer',

							['l.'] = '@call.inner',
							['a.'] = '@call.outer',
							['l,'] = '@parameter.inner',
							['a,'] = '@parameter.outer',
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]]"] = "@class.outer",
							[']l'] = '@loop.outer',
							[']i'] = '@conditional.outer',
							['],'] = '@parameter.outer',
							['].'] = '@call.outer',
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[["] = "@class.outer",
							['[l'] = '@loop.outer',
							['[i'] = '@conditional.outer',
							['[,'] = '@parameter.outer',
							['[.'] = '@call.outer',
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["sn,"] = "@parameter.inner",
						},
						swap_previous = {
							["sp,"] = "@parameter.inner",
						},
					},
					-- lsp_interop = {
					-- 	enable = true,
					-- 	border = 'none',
					-- 	peek_definition_code = {
					-- 		["gpf"] = "@function.outer",
					-- 		["gpc"] = "@class.outer",
					-- 	},
					-- },
				},
			}
		end
	}
}

-- run test
use {
	{'thinca/vim-quickrun',
		config = function ()
			vim.g.quickrun_no_default_key_mappings = 1
			vim.g.quickrun_config = { _ = { outputter = "message" }}
			vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>(quickrun)', { noremap=false, silent=false })
		end,
	},
	{'vim-test/vim-test',
		config = function ()
			vim.cmd([[
				nmap <silent> <leader>tl :TestLast -v<CR>
				nmap <silent> <leader>tv :TestVisit<CR>
			]])
		end
	},
	{'sebdah/vim-delve',
		config = function ()
			vim.cmd([[
				nmap <leader>bb :DlvToggleBreakpoint<CR>
			]])
		end
	}
}

-- auto complete
use {
	{'neovim/nvim-lspconfig', config = function() require('lsp') end},
	{'onsails/lspkind-nvim',
		config = function()
			require('lspkind').init({
				-- enables text annotations
				with_text = true,
				-- can be either 'default' or
				-- 'codicons' for codicon preset (requires vscode-codicons font installed)
				-- default: 'default'
				preset = 'codicons',
				-- override preset symbols
				symbol_map = {
					Text = '',
					Method = 'ƒ',
					Function = '',
					Constructor = '',
					Variable = '',
					Field = '',
					Class = '',
					Interface = 'ﰮ',
					Module = '',
					Property = '',
					Unit = '',
					Value = '',
					Enum = '',
					Keyword = '',
					Snippet = '﬌',
					Color = '',
					File = '',
					Folder = '',
					EnumMember = '',
					Constant = '',
					Struct = ''
				}
			})
		end
	},
  -- { 'mfussenegger/nvim-lsp-compl',
  -- 		requires = {
  -- 			{'hrsh7th/vim-vsnip' },
  -- 			{'rafamadriz/friendly-snippets'},
  -- 		},
  --   config = function()
  -- 			require('lsp_compl').expand_snippet = vim.fn['vsnip#anonymous']
  -- 		end
  -- },
	{'hrsh7th/nvim-compe',
		requires = {
			{'hrsh7th/vim-vsnip' },
			{'rafamadriz/friendly-snippets'},
		},
		config = function ()
			require('compe').setup {
				min_length = 2;
				preselect = 'disable';
				max_menu_width = 20;
				max_abbr_width = 20;
				max_kind_width = 20;
				source = {
					path = true;
					buffer = true;
					tags = false;

					nvim_lsp = true;
					nvim_lua = true;

					vsnip = true;
					luasnip = false;
					ultisnips = false;
					calc = false;
				},
			}

			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end
			-- Use (s-)tab to:
			--- move to prev/next item in completion menuone
			--- jump to prev/next snippet's placeholder
			_G.tab_complete = function()
				if is_pairs() then
					return t "<Right>"
				elseif vim.fn['vsnip#available'](1) == 1 then
					return t "<Plug>(vsnip-expand-or-jump)"
				elseif vim.fn.pumvisible() == 1 then
					return vim.fn['compe#confirm']({ keys = '<CR>', select = true })
				elseif check_back_space() then
					return t "<Tab>"
				else
					return vim.fn['compe#complete']()
				end
			end
			_G.s_tab_complete = function()
				if is_pairs(true) then
					return t "<Left>"
				elseif vim.fn['vsnip#jumpable'](-1) == 1 then
					return t "<Plug>(vsnip-jump-prev)"
				elseif check_back_space() then
					return t "<S-Tab>"
				else
					return vim.fn['compe#complete']()
				end
			end
			vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
			vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
			vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
			vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

			-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
		end
	},
	{ 'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
			require("nvim-autopairs.completion.compe").setup({
				map_cr = true, --  map <CR> on insert mode
				map_complete = true, -- it will auto insert `(` after select function or method item
				auto_select = true,  -- auto select first item
			})
		end
	},
	{ 'simrat39/symbols-outline.nvim',
		requires = {'neovim/nvim-lspconfig'},
		config = function()
			vim.g.symbols_outline = {
				auto_preview = false,
			}
		end
	},
	{ 'terrortylor/nvim-comment',
		config = function () require('nvim_comment').setup() end
	},
}

-- UI
use {{
	'navarasu/onedark.nvim',
		config = function ()
			-- vim.g.onedark_transparent_background = true
			vim.cmd [[ colorscheme onedark ]]
		end
	},
	{ 'lukas-reineke/indent-blankline.nvim', cmd = 'IndentBlanklineToggle', ft = 'lua',
		setup = function()
			vim.g.indent_blankline_char = '┊'
			vim.g.indent_blankline_filetype_exclude = { 'help', 'packer', 'nvimtree' }
			vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile', 'packer' }
			vim.g.indent_blankline_show_first_indent_level = false
			vim.g.indent_blankline_char_highlight = 'LineNr'
			vim.g.indent_blankline_show_trailing_blankline_indent = false
		end
	},
	{ 'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			vim.g.nvim_tree_auto_close = 1
			vim.g.nvim_tree_auto_open = 1
			vim.g.nvim_tree_quit_on_open = 1
			vim.g.nvim_tree_highlight_opened_files = 3
			vim.g.nvim_tree_follow = 1
			vim.g.nvim_tree_width_allow_resize  = 1
			-- vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', 'logs'}
			vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }

			vim.api.nvim_set_keymap('n', '<leader><leader>', ':NvimTreeFindFile<CR>', { noremap=true, silent=true })
			vim.api.nvim_set_keymap('n', 'q', ':NvimTreeClose<CR>', { noremap=true, silent=true })
		end,
	},
	{ 'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons'},
		config = function()
			local function lsp()
				local icon = [[ ]]
				local msg = 'No Active LSP'
				local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then return icon .. msg end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return icon .. client.name
					end
				end
				return icon .. msg
			end
			require('lualine').setup{
				options = {
					theme = 'onedark',
					section_separators = '', component_separators = '',
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {{'branch'}, {'diff'}},
					lualine_c = {{'filename'}, {
						'diagnostics',
						sources = {'nvim_lsp'},
						-- symbols = {error = ' ', warn = ' ', info = ' '}
					}},
					lualine_x = {{lsp}, {'encoding'}, {'fileformat'}, 'filetype'},
					lualine_y = {'progress'},
					lualine_z = {'location'}
				},
				extensions = {'nvim-tree'},
			}
		end
	},
	{ 'akinsho/nvim-bufferline.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function ()
			require("bufferline").setup{
				options = {
					offsets = {{filetype = "NvimTree", text = "Press g? for help", text_align = "left"}}
				}
			}
		end
	},
	-- { 'xiyaowong/nvim-transparent',
	-- 	config = function()
	-- 		require("transparent").setup({
	-- 			enable = true,
	-- 			extra_groups = {"NvimTreeNormal", "NvimTreeEndOfBuffer" }
	-- 		})
	-- 	end
	-- },
}
end)



--   use {
--     'neoclide/coc.nvim',
-- 		requires = {
-- 			{ 'honza/vim-snippets' },
-- 		},
--     branch = 'release',
--     config = function ()
--       vim.cmd([[
--         let g:coc_snippet_next = '<Tab>'
--         let g:coc_snippet_prev = '<S-Tab>'
--         let g:snips_author = 'bucai'
 
--         let g:coc_global_extensions =[ 'coc-marketplace', 'coc-snippets', 'coc-json' ]
-- 
--         autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')
 
--         inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
 
--         nmap <silent>[g <Plug>(coc-diagnostic-prev)
--         nmap <silent>]g <Plug>(coc-diagnostic-next)
 
--         nmap <silent>gd <Plug>(coc-definition)
--         nmap <silent>gD <Plug>(coc-declaration)
--         nmap <silent>gy <Plug>(coc-type-definition)
--         nmap <silent>gi <Plug>(coc-implementation)
--         nmap <silent>gr <Plug>(coc-references)
--         nmap <silent>rn <Plug>(coc-rename)
 
--         nmap <silent><leader>fc <Plug>(coc-fix-current)
--         nmap <silent><leader>rf <Plug>(coc-refactor)
 
--         nmap <silent><leader>ca <Plug>(coc-codeaction)
 
--         nnoremap <silent><leader><leader>l :<C-u>CocList<cr>
--         nnoremap <silent><leader><leader>a :<C-u>CocList diagnostics<cr>
--         nnoremap <silent><leader><leader>o :<C-u>CocList outline<cr>
--         " nnoremap <silent><leader><leader>s :<C-u>CocList -I symbols<cr>
--         nnoremap <silent><leader><leader>n :<C-u>CocNext<CR>
--         nnoremap <silent><leader><leader>p :<C-u>CocPrev<CR>
--         nnoremap <silent><leader><leader>r :<C-u>CocListResume<CR>
 
-- 				" Use K to show documentation in preview window
--         nnoremap <silent>E :call CocActionAsync('doHover')<CR>
 
-- 				nmap <Leader>tr <Plug>(coc-translator-p)
-- 				vmap <Leader>tr <Plug>(coc-translator-pv)
--			 ]])
--     end
--   }
