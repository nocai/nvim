require("global")
require("option")
require("autocmd")
-- vim.lsp.set_log_level("debug")

-- Install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone git@github.com/wbthomason/packer.nvim " .. install_path)
end
vim.cmd([[autocmd BufWritePost init.lua PackerCompile]])

local packer = require("packer")
packer.init {git = {default_url_format = "git@github.com:/%s"}}

local use = require("packer").use
require("packer").startup(
  function()
    use {"wbthomason/packer.nvim"} -- Package manager

    -- misc
    use {
      -- { "tpope/vim-surround" },
      -- { 'tpope/vim-repeat' },
      -- { 'jiangmiao/auto-pairs' },
      {"tweekmonster/startuptime.vim", cmd = {"StartupTime"}},
      {"nanotee/nvim-lua-guide"},
      {
        "norcalli/nvim-colorizer.lua",
        config = function()
          require "colorizer".setup()
        end
      },
      {"kshenoy/vim-signature"},
      {"npxbr/glow.nvim", run = "GlowInstall", cmd = "Glow"},
      {
        "voldikss/vim-translator",
        cmd = {"TranslateW"},
        keys = {"<leader>tr"},
        config = function()
          vim.g.translator_default_engines = {"youdao", "bing"}
          vim.api.nvim_set_keymap("n", "<leader>tr", ":TranslateW<CR>", {silent = true, noremap = true})
          vim.api.nvim_set_keymap("x", "<leader>tr", ":TranslateW<CR>", {silent = true, noremap = true})
        end
      },
      {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
          require("neoscroll").setup(
            {
              mappings = {
                "<C-u>",
                "<C-d>",
                "<C-b>",
                "<C-f>",
                "<C-y>",
                "zt",
                "zz",
                "zb"
              }
            }
          )
          require("neoscroll.config").set_mappings({["<C-j>"] = {"scroll", {"0.10", "false", "100"}}})
        end
      },
      {
        "machakann/vim-sandwich",
        event = {"BufRead"},
        config = function()
          vim.g.textobj_sandwich_no_default_key_mappings = 1
          vim.cmd(
            [[
				silent! omap <unique> lb <Plug>(textobj-sandwich-auto-i)
				silent! xmap <unique> lb <Plug>(textobj-sandwich-auto-i)
				silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
				silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

				silent! omap <unique> ls <Plug>(textobj-sandwich-query-i)
				silent! xmap <unique> ls <Plug>(textobj-sandwich-query-i)
				silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
				silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
			]]
          )
        end
      },
      -- {
      --   "voldikss/vim-floaterm",
      --   cmd = {"FloatermToggle", "FloatermNew"},
      --   keys = {"<F7>", "<F8>", "<F9>", "<F12>", "<M-t>"},
      --   config = function()
      --     vim.cmd(
      --       [[
      -- 						 let g:floaterm_keymap_new    = '<F7>'
      -- 						 let g:floaterm_keymap_prev   = '<F8>'
      -- 						 let g:floaterm_keymap_next   = '<F9>'
      -- 						 let g:floaterm_keymap_toggle = '<F12>'
      -- 						 nnoremap <silent> <M-t> :FloatermToggle<CR>
      -- 						 tnoremap <silent> <M-t> <C-\><C-n>:FloatermToggle<CR>
      -- 					 ]]
      --     )
      --   end
      -- },
      {
        "akinsho/toggleterm.nvim",
        config = function()
          require("toggleterm").setup {
            -- size can be a number or function which is passed the current terminal
            -- size = 20 | function(term)
            -- 	if term.direction == "horizontal" then
            -- 		return 15
            -- 	elseif term.direction == "vertical" then
            -- 		return vim.o.columns * 0.4
            -- 	end
            -- end,
            size = function(term)
              if term.direction == "horizontal" then
                return 15
              elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
              end
            end,
            open_mapping = [[<c-\>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
            direction = "float",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
              -- The border key is *almost* the same as 'nvim_open_win'
              -- see :h nvim_open_win for details on borders however
              -- the 'curved' border is a custom border type
              -- not natively supported but implemented in this plugin.
              -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
              border = "curved",
              -- width = <value>,
              -- height = <value>,
              winblend = 3,
              highlights = {
                border = "Normal",
                background = "Normal"
              }
            }
          }
        end
      }
    }

    -- textobject
    use {
      {
        "kana/vim-textobj-user",
        event = {"BufRead"}
      },
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
      {
        "sgur/vim-textobj-parameter",
        after = {"vim-textobj-user"},
        requires = {"kana/vim-textobj-user"},
        config = function()
          vim.cmd(
            [[
				let g:textobj_parameter_no_default_key_mappings=1
				xmap la <Plug>(textobj-parameter-i)
				omap la <Plug>(textobj-parameter-i)
				xmap aa <Plug>(textobj-parameter-a)
				omap aa <Plug>(textobj-parameter-a)
			]]
          )
        end
      }
    }

    -- telescope
    use {
      {
        "nvim-telescope/telescope.nvim",
        keys = {"<c-p>"},
        requires = {{"nvim-lua/plenary.nvim"}},
        config = function()
          local actions = require "telescope.actions"
          require("telescope").setup {
            defaults = {
              prompt_prefix = "  ",
              previewers = true,
              mappings = {
                i = {
                  ["<C-k>"] = actions.move_selection_next,
                  ["<C-e>"] = actions.move_selection_previous,
                  ["<C-l>"] = false,
                  ["<C-i>"] = actions.complete_tag
                },
                n = {
                  ["j"] = false,
                  ["L"] = false,
                  ["n"] = actions.move_selection_next,
                  ["k"] = actions.move_selection_next,
                  ["p"] = actions.move_selection_previous,
                  ["e"] = actions.move_selection_previous,
                  ["I"] = actions.move_to_bottom
                }
              }
            }
          }

          vim.api.nvim_set_keymap(
            "n",
            "<c-p>p",
            [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p><c-p>",
            [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
            {noremap = true, silent = true}
          )

          vim.api.nvim_set_keymap(
            "n",
            "<c-p>g",
            [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p><c-g>",
            [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
            {noremap = true, silent = true}
          )

          vim.api.nvim_set_keymap(
            "n",
            "<c-p>b",
            [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p><c-b>",
            [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
            {noremap = true, silent = true}
          )

          vim.api.nvim_set_keymap(
            "n",
            "<c-p>h",
            [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
            {noremap = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p><c-h>",
            [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
            {noremap = true}
          )

          vim.api.nvim_set_keymap(
            "n",
            "<c-p>gs",
            [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p>gr",
            [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p>gi",
            [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p>dd",
            [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]],
            {noremap = true, silent = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<c-p>wd",
            [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]],
            {noremap = true, silent = true}
          )
        end
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
        run = "make",
        config = function()
          require("telescope").setup {
            extensions = {
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = false, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
              }
            }
          }
          require("telescope").load_extension("fzf")
        end
      }
    }

    -- git
    use {
      {"tpope/vim-fugitive", cmd = "G"},
      {
        "lewis6991/gitsigns.nvim",
        event = {"BufRead"},
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
          require("gitsigns").setup {
            current_line_blame = true,
            signs = {
              add = {text = "+"},
              change = {text = "~"},
              delete = {text = "_"},
              topdelete = {text = "‾"},
              changedelete = {text = "~"}
            },
            keymaps = {
              noremap = true,
              ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''},
              ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''},
              ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
              ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
              ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
              ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
              ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
              ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
              ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
              ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
              -- Text objects
              ["o lh"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
              ["x lh"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
            }
          }
        end
      }
    }

    -- treesitter
    use {
      {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufRead"},
        run = ":TSUpdate",
        config = function()
          -- :TSInstall
          require("nvim-treesitter.configs").setup {
            indent = {enable = true},
            highlight = {enable = true},
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm"
              }
            }
          }
          -- vim.api.nvim_command('set foldmethod=expr')
          -- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
        end
      },
      {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        requires = {"nvim-treesitter/nvim-treesitter"},
        config = function()
          require "nvim-treesitter.configs".setup {
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
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = {"nvim-treesitter/nvim-treesitter"},
        config = function()
          require("nvim-treesitter.configs").setup {
            textobjects = {
              select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["lf"] = "@function.inner",
                  ["af"] = "@function.outer",
                  ["lc"] = "@class.inner",
                  ["ac"] = "@class.outer",
                  ["ll"] = "@loop.inner",
                  ["al"] = "@loop.outer",
                  ["li"] = "@conditional.inner",
                  ["ai"] = "@conditional.outer",
                  ["l."] = "@call.inner",
                  ["a."] = "@call.outer",
                  ["l,"] = "@parameter.inner",
                  ["a,"] = "@parameter.outer"
                }
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]f"] = "@function.outer",
                  ["]]"] = "@class.outer",
                  ["]l"] = "@loop.outer",
                  ["]i"] = "@conditional.outer",
                  ["],"] = "@parameter.outer",
                  ["]."] = "@call.outer"
                },
                goto_next_end = {
                  ["]F"] = "@function.outer",
                  ["]["] = "@class.outer"
                },
                goto_previous_start = {
                  ["[f"] = "@function.outer",
                  ["[["] = "@class.outer",
                  ["[l"] = "@loop.outer",
                  ["[i"] = "@conditional.outer",
                  ["[,"] = "@parameter.outer",
                  ["[."] = "@call.outer"
                },
                goto_previous_end = {
                  ["[F"] = "@function.outer",
                  ["[]"] = "@class.outer"
                }
              },
              swap = {
                enable = true,
                swap_next = {
                  ["sn,"] = "@parameter.inner"
                },
                swap_previous = {
                  ["sp,"] = "@parameter.inner"
                }
              }
              -- lsp_interop = {
              -- 	enable = true,
              -- 	border = 'none',
              -- 	peek_definition_code = {
              -- 		["gpf"] = "@function.outer",
              -- 		["gpc"] = "@class.outer",
              -- 	},
              -- },
            }
          }
        end
      }
    }

    -- run test
    use {
      {
        "thinca/vim-quickrun",
        cmd = "QuickRun",
        keys = "<leader>rr",
        config = function()
          vim.g.quickrun_no_default_key_mappings = 1
          vim.g.quickrun_config = {_ = {outputter = "message"}}
          vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>(quickrun)", {noremap = false, silent = false})
        end
      },
      {
        "vim-test/vim-test",
        cmd = "TestNearest",
        config = function()
          vim.cmd(
            [[
						nmap <silent> <leader>tl :TestLast -v<CR>
						nmap <silent> <leader>tv :TestVisit<CR>
					]]
          )
        end
      },
      {
        "sebdah/vim-delve",
        cmd = "DlvToggleBreakpoint",
        config = function()
          vim.cmd([[nmap <leader>bb :DlvToggleBreakpoint<CR>]])
        end
      }
    }

    -- auto complete
    use {
      {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = function()
          require("lsp")
        end
      },
      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        requires = {
          {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
              require("nvim-autopairs").setup {}
              require("nvim-autopairs.completion.cmp").setup {
                map_cr = true, --  map <CR> on insert mode
                map_complete = true, -- it will auto insert `(` after select function or method item
                auto_select = true
              }
            end
          },
          {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"},
          {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
          {
            "saadparwaiz1/cmp_luasnip",
            after = "nvim-cmp",
            requires = {
              {
                "L3MON4D3/LuaSnip",
                after = "cmp_luasnip",
                requires = {
                  {
                    "rafamadriz/friendly-snippets",
                    after = {"LuaSnip"},
                    config = function()
                      require("luasnip.loaders.from_vscode").load()
                    end
                  }
                }
              }
            }
          }
        },
        config = function()
          local lspkind_icons = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = ""
          }
          local cmp = require("cmp")
          cmp.setup {
            preselect = cmp.PreselectMode.None,
            enabled = function()
              return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            end,
            snippet = {
              expand = function(args)
                require "luasnip".lsp_expand(args.body)
              end
            },
            completion = {
              keyword_length = 3
              -- autocomplete = false
            },
            formatting = {
              format = function(entry, vim_item)
                vim_item.kind = lspkind_icons[vim_item.kind] .. " " .. vim_item.kind -- string.sub(vim_item.kind, 1, 4)
                -- set a name for each source
                -- vim_item.menu =
                --   ({
                --   buffer = "[Buffer]",
                --   nvim_lsp = "[LSP]",
                --   luasnip = "[LuaSnip]",
                --   nvim_lua = "[Lua]",
                --   latex_symbols = "[Latex]"
                -- })[entry.source.name]
                return vim_item
              end
            },
            -- You must set mapping.
            mapping = {
              ["<C-n>"] = cmp.mapping.select_next_item(),
              ["<C-k>"] = cmp.mapping.select_next_item(),
              ["<C-p>"] = cmp.mapping.select_prev_item(),
              ["<C-e>"] = cmp.mapping.select_prev_item(),
              ["<C-u>"] = cmp.mapping.scroll_docs(-4),
              ["<C-d>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-j>"] = cmp.mapping.abort(),
              -- ['<CR>'] = cmp.mapping.confirm({
              -- 	select = true,
              -- }),
              ["<Tab>"] = cmp.mapping(
                function(fallback)
                  if require("luasnip").expand_or_jumpable() then
                    vim.api.nvim_feedkeys(
                      vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                      "",
                      true
                    )
                  elseif is_pairs() then
                    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n")
                  else
                    fallback()
                  end
                end,
                {"i", "s"}
              ),
              ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                  if require("luasnip").jumpable(-1) then
                    vim.api.nvim_feedkeys(
                      vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
                      "",
                      true
                    )
                  elseif is_pairs(true) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, true, true), "n")
                  else
                    fallback()
                  end
                end,
                {"i", "s"}
              )
            },
            -- You should specify your *installed* sources.
            sources = {
              {name = "nvim_lsp"},
              {name = "buffer"},
              {name = "luasnip"}
            }
          }
          -- vim.cmd([[ autocmd FileType lua lua require('cmp').setup.buffer { sources = { {name='nvim_lua'} } } ]])
        end
      },
      {
        "mhartington/formatter.nvim",
        -- cmd = {"Format", "FormatWrite"},
        -- events = {"BufWritePre"},
        config = function()
          require("formatter").setup {
            filetype = {
              rust = {
                -- Rustfmt
                function()
                  return {
                    exe = "rustfmt",
                    args = {"--emit=stdout"},
                    stdin = true
                  }
                end
              },
              lua = {
                -- luafmt
                function()
                  return {
                    exe = "luafmt",
                    args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                  }
                end
              }
            }
          }

          vim.cmd(
            [[ 
						augroup FormatAutogroup
							autocmd!
							autocmd BufWritePost *.rs,*.lua FormatWrite
						augroup END 
						]]
          )
        end
      },
      {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = "gO",
        requires = {"neovim/nvim-lspconfig"},
        setup = function()
          vim.g.symbols_outline = {
            auto_preview = false
          }
        end,
        config = function()
          vim.api.nvim_set_keymap("n", "gO", ":SymbolsOutline<CR>", {noremap = true, silent = true})
        end
      },
      {
        "terrortylor/nvim-comment",
        keys = {"gc", "gcc"},
        config = function()
          require("nvim_comment").setup()
        end
      },
      {
        "folke/trouble.nvim",
        cmd = {"Trouble"},
        keys = {"<leader>tn", "<leader>tp", "<leader>dd", "<leader>wd"},
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
          require("trouble").setup {
            position = "bottom", -- position of the list can be: bottom, top, left, right
            height = 10, -- height of the trouble list when position is top or bottom
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
            fold_open = "", -- icon used for open folds
            fold_closed = "", -- icon used for closed folds
            action_keys = {
              -- key mappings for actions in the trouble list
              -- map to {} to remove a mapping, for example:
              -- close = {},
              close = "q", -- close the list
              cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
              refresh = "r", -- manually refresh
              jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
              open_split = {"<c-x>"}, -- open buffer in new split
              open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
              open_tab = {"<c-t>"}, -- open buffer in new tab
              jump_close = {"o"}, -- jump to the diagnostic and close the list
              toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
              toggle_preview = "P", -- toggle auto_preview
              hover = "E", -- opens a small popup with the full multiline message
              preview = "p", -- preview the diagnostic location
              close_folds = {"zM", "zm"}, -- close all folds
              open_folds = {"zR", "zr"}, -- open all folds
              toggle_fold = {"zA", "za"}, -- toggle fold of current file
              previous = "e", -- preview item
              next = "n" -- next item
            },
            indent_lines = true, -- add an indent guide below the fold icons
            auto_open = false, -- automatically open the list when you have diagnostics
            auto_close = true, -- automatically close the list when you have no diagnostics
            auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false, -- automatically fold a file trouble list at creation
            signs = {
              -- icons / text used for a diagnostic
              error = "",
              warning = "",
              hint = "",
              information = "",
              other = "﫠"
            },
            use_lsp_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
          }

          vim.api.nvim_set_keymap(
            "n",
            "<leader>tn",
            "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
            {silent = true, noremap = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<leader>tp",
            "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
            {silent = true, noremap = true}
          )
          vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
          vim.api.nvim_set_keymap(
            "n",
            "<leader>dd",
            "<cmd>Trouble lsp_document_diagnostics<cr>",
            {silent = true, noremap = true}
          )
          vim.api.nvim_set_keymap(
            "n",
            "<leader>wd",
            "<cmd>Trouble lsp_workspace_diagnostics<cr>",
            {silent = true, noremap = true}
          )
        end
      }
    }

    -- UI
    use {
      -- {
      --   "navarasu/onedark.nvim",
      --   config = function()
      --     -- vim.g.onedark_transparent_background = true
      --     -- vim.cmd [[ colorscheme onedark ]]
      --   end
      -- },
      {
        "shaunsingh/nord.nvim",
        config = function()
          -- vim.g.nord_disable_background = true
          -- vim.cmd[[colorscheme nord]]
        end
      },
      {
        "folke/tokyonight.nvim",
        config = function()
          vim.g.tokyonight_style = "night" -- storm, night, day
          -- vim.g.tokyonight_transparent = true
          vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer", "NvimTree"}
          -- vim.g.tokyonight_italic_functions = true
          vim.cmd [[colorscheme tokyonight]]
        end
      },
      {
        "lukas-reineke/indent-blankline.nvim",
        cmd = "IndentBlanklineToggle",
        ft = "lua",
        setup = function()
          vim.g.indent_blankline_char = "┊"
          vim.g.indent_blankline_filetype_exclude = {"help", "packer", "nvimtree"}
          vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile", "packer"}
          vim.g.indent_blankline_show_first_indent_level = false
          vim.g.indent_blankline_char_highlight = "LineNr"
          vim.g.indent_blankline_show_trailing_blankline_indent = false
        end
      },
      {
        "kyazdani42/nvim-tree.lua",
        events = {"VimEnter"},
        -- keys = {"<leader><leader>"},
        -- cmd = {"NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile"},
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
          vim.g.nvim_tree_disable_default_keybindings = 1
          vim.g.nvim_tree_auto_close = 1
          vim.g.nvim_tree_auto_open = 1
          vim.g.nvim_tree_quit_on_open = 1
          vim.g.nvim_tree_highlight_opened_files = 3
          vim.g.nvim_tree_follow = 1
          vim.g.nvim_tree_width_allow_resize = 1
          -- vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', 'logs'}
          vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1, folder_arrows = 1}
          vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>NvimTreeFindFile<CR>", {noremap = true, silent = true})

          local tree_cb = require "nvim-tree.config".nvim_tree_callback
          vim.g.nvim_tree_bindings = {
            {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
            {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
            {key = "<C-v>", cb = tree_cb("vsplit")},
            {key = "<C-x>", cb = tree_cb("split")},
            {key = "<C-t>", cb = tree_cb("tabnew")},
            {key = "<", cb = tree_cb("prev_sibling")},
            {key = ">", cb = tree_cb("next_sibling")},
            {key = "P", cb = tree_cb("parent_node")},
            {key = "<BS>", cb = tree_cb("close_node")},
            {key = "<S-CR>", cb = tree_cb("close_node")},
            {key = "<Tab>", cb = tree_cb("preview")},
            {key = "E", cb = tree_cb("first_sibling")},
            {key = "N", cb = tree_cb("last_sibling")},
            {key = "I", cb = tree_cb("toggle_ignored")},
            {key = "H", cb = tree_cb("toggle_dotfiles")},
            {key = "R", cb = tree_cb("refresh")},
            {key = "a", cb = tree_cb("create")},
            {key = "d", cb = tree_cb("remove")},
            {key = "r", cb = tree_cb("rename")},
            {key = "<C-r>", cb = tree_cb("full_rename")},
            {key = "x", cb = tree_cb("cut")},
            {key = "c", cb = tree_cb("copy")},
            {key = "p", cb = tree_cb("paste")},
            {key = "y", cb = tree_cb("copy_name")},
            {key = "Y", cb = tree_cb("copy_path")},
            {key = "gy", cb = tree_cb("copy_absolute_path")},
            {key = "[c", cb = tree_cb("prev_git_item")},
            {key = "]c", cb = tree_cb("next_git_item")},
            {key = "-", cb = tree_cb("dir_up")},
            {key = "s", cb = tree_cb("system_open")},
            {key = "q", cb = tree_cb("close")},
            {key = "g?", cb = tree_cb("toggle_help")}
          }
        end
      },
      {
        "hoob3rt/lualine.nvim",
        event = {"VimEnter"},
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
          local function lsp()
            local icon = [[ ]]
            local msg = "No Active LSP"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
              return icon .. msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return icon .. client.name
              end
            end
            return icon .. msg
          end
          require("lualine").setup {
            options = {
              -- theme = "onedark",
              theme = "tokyonight",
              -- theme = "nord",
              section_separators = "",
              component_separators = ""
            },
            sections = {
              lualine_a = {"mode"},
              lualine_b = {{"branch"}, {"diff"}},
              lualine_c = {
                {"filename"},
                {
                  "diagnostics",
                  sources = {"nvim_lsp"}
                  -- symbols = {error = ' ', warn = ' ', info = ' '}
                }
              },
              lualine_x = {{lsp}, {"encoding"}, {"fileformat"}, "filetype"},
              lualine_y = {"progress"},
              lualine_z = {"location"}
            },
            extensions = {"nvim-tree"}
          }
        end
      },
      {
        "akinsho/nvim-bufferline.lua",
        event = {"BufRead"},
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
          require("bufferline").setup {
            options = {
              offsets = {{filetype = "NvimTree", text = "Press g? for help", text_align = "left"}}
            }
          }
        end
      },
      {
        "sunjon/shade.nvim",
        -- keys = "<C-W>",
        config = function()
          require "shade".setup(
            {
              overlay_opacity = 60,
              opacity_step = 1,
              keys = {
                brightness_up = "<C-Up>",
                brightness_down = "<C-Down>"
                -- toggle           = '<Leader>s',
              }
            }
          )
        end
      }
      -- { 'xiyaowong/nvim-transparent',
      -- 	config = function()
      -- 		require("transparent").setup({
      -- 			enable = true,
      -- 			extra_groups = {"NvimTreeNormal", "NvimTreeEndOfBuffer" }
      -- 		})
      -- 	end
      -- },
    }
  end
)

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
