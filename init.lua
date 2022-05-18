require("nvim")
require("option")
require("autocmd")

local present, impatient = pcall(require, "impatient")
if present then
	impatient.enable_profile()
end

local present2, packer = pcall(require, "configs.packer")
if not present2 then
	return
end

return packer.startup(function(use)
	use({ "lewis6991/impatient.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "nanotee/nvim-lua-guide" })
	use({ "wbthomason/packer.nvim", opt = true })
	use({ "nathom/filetype.nvim", disable = true })

	-- UI
	use({
		{
			"sainnhe/sonokai",
			disable = true,
			cond = function()
				return not nvim.is_vscode
			end,
			setup = function()
				require("configs.ui").sonokai()
			end,
			config = function()
				vim.cmd([[colorscheme sonokai]])
			end,
		},
		{
			"folke/tokyonight.nvim",
			-- disable = true,
			cond = function()
				return not nvim.is_vscode
			end,
			setup = function()
				require("configs.ui").tokyonight()
			end,
			config = function()
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
		{
			"kyazdani42/nvim-web-devicons",
			cond = function()
				return not nvim.is_vscode
			end,
		},
		{
			"kyazdani42/nvim-tree.lua",
			cond = function()
				return not nvim.is_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("configs.ui").nvim_tree()
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			cond = function()
				return not nvim.is_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("configs.ui").lualine()
			end,
		},
		{
			"akinsho/nvim-bufferline.lua",
			cond = function()
				return false
				-- return not nvim.is_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("configs.ui").nvim_bufferline()
			end,
		},
	})

	-- misc
	use({
		{
			"tweekmonster/startuptime.vim",
			cond = function()
				return not nvim.is_vscode
			end,
			cmd = { "StartupTime" },
		},
		{
			"voldikss/vim-translator",
			cond = function()
				return not nvim.is_vscode
			end,
			event = "VimEnter",
			config = function()
				require("configs.misc").vim_translator()
			end,
		},
		{
			"karb94/neoscroll.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = "WinScrolled",
			config = function()
				require("configs.misc").neoscroll()
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			keys = { "<C-\\>" },
			cmd = { "Glow" },
			config = function()
				require("configs.misc").toggleterm()
			end,
		},
		{
			"rhysd/accelerated-jk",
			event = { "BufRead" },
			setup = function()
				vim.cmd([[
					nmap <silent>n <Plug>(accelerated_jk_gj)
					nmap <silent>e <Plug>(accelerated_jk_gk)
				]])
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			cond = function()
				return not vim.g.vscode
			end,
			event = "VimEnter",
			ft = { "lua", "html", "css" },
			config = function()
				require("colorizer").setup()
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = "VimEnter",
			setup = function()
				require("configs.misc").indent_blankline()
			end,
		},
		{
			"kshenoy/vim-signature",
			cond = function()
				return not vim.g.vscode
			end,
			event = "VimEnter",
		},
		{
			"machakann/vim-sandwich",
			event = { "BufRead" },
			setup = function()
				vim.g.textobj_sandwich_no_default_key_mappings = 1
			end,
			config = function()
				require("configs.misc").vim_sandwich()
			end,
		},
	})

	-- textobject
	use({
		{
			"kana/vim-textobj-user",
			event = { "BufRead" },
		},
		{
			"kana/vim-textobj-indent",
			after = { "vim-textobj-user" },
			setup = function()
				vim.g.textobj_indent_no_default_key_mappings = 1
			end,
			config = function()
				require("configs.misc").vim_textobj_indent()
			end,
		},
		{
			"sgur/vim-textobj-parameter",
			after = { "vim-textobj-user" },
			setup = function()
				vim.g.textobj_parameter_no_default_key_mappings = 1
			end,
			config = function()
				require("configs.misc").vim_textobj_parameter()
			end,
		},
	})

	-- tools
	use({
		{
			"tpope/vim-fugitive",
			cond = function()
				return not vim.g.vscode
			end,
			cmd = { "G", "Git" },
		},
		{
			"lewis6991/gitsigns.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "BufRead" },
			config = function()
				require("configs.tools").gitsigns()
			end,
		},
		{
			"thinca/vim-quickrun",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust" },
			config = function()
				require("configs.tools").vim_quickrun()
			end,
		},
		{
			"vim-test/vim-test",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust", "java" },
			config = function()
				require("configs.tools").vim_quickrun()
			end,
		},
		{
			"sebdah/vim-delve",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go" },
		},
		{
			"numToStr/Comment.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = "BufReadPre",
			config = function()
				require("configs.tools").comment()
			end,
		},
		{
			"junegunn/vim-easy-align",
			keys = { "<leader>ga" },
			config = function()
				vim.cmd([[
					nmap <leader>ga <Plug>(EasyAlign)
					xmap <leader>ga <Plug>(EasyAlign)
				]])
			end,
		},
		{
			"folke/todo-comments.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = "BufRead",
			config = function()
				require("todo-comments").setup()
			end,
		},
		{
			"ggandor/lightspeed.nvim",
			disable = true,
			event = "BufRead",
			cond = function()
				return not vim.g.vscode
			end,
		},
		{
			"npxbr/glow.nvim",
			disable = true,
			cond = function()
				return not vim.g.vscode
			end,
			run = "GlowInstall",
			cmd = "Glow",
		},
	})

	-- telescope
	use({
		{
			"nvim-telescope/telescope.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "VimEnter" },
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("configs.telescope").config()
			end,
		},

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			after = { "telescope.nvim" },
			-- run = "make",
			config = function()
				require("configs.telescope").telescope_fzf_native()
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			after = { "telescope.nvim" },
			config = function()
				require("configs.telescope").telescope_ui_selet()
			end,
		},
	})

	-- treesitter
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "BufRead", "BufNewFile" },
			run = ":TSUpdate",
			config = function()
				require("configs.treesitter").nvim_treesitter()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
			config = function()
				require("configs.treesitter").nvim_treesitter_textobjects()
			end,
		},
		{
			"p00f/nvim-ts-rainbow",
			after = "nvim-treesitter",
			config = function()
				require("configs.treesitter").nvim_ts_tainbow()
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			after = "nvim-treesitter",
			config = function()
				require("nvim-treesitter.configs").setup({
					autotag = {
						enable = true,
					},
				})
			end,
		},
		{
			"andymass/vim-matchup",
			after = "nvim-treesitter",
			event = { "CursorMoved" },
			config = function()
				require("configs.treesitter").vim_match()
			end,
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			after = { "nvim-treesitter" },
			config = function()
				require("configs.treesitter").nvim_ts_context_commentstring()
			end,
		},
	})

	-- lsp
	use({
		{
			"neovim/nvim-lspconfig",
			cond = function()
				return not vim.g.vscode
			end,
			event = "VimEnter",
			config = function()
				require("configs.lsp").nvim_lspconfig()
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "lua" },
			config = function()
				require("configs.lsp").null_ls()
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			disable = true, -- 不知道为什么，在本地签名窗口会抖动（弹出两次）
			cond = function()
				return not vim.g.vscode
			end,
			after = { "nvim-lspconfig" },
			config = function()
				require("configs.lsp").lsp_signature()
			end,
		},
		{
			-- config, see: ftplugin/java.lua
			"mfussenegger/nvim-jdtls",
			ft = { "java" },
			cond = function()
				return not vim.g.vscode
			end,
		},
	})

	-- cmp
	use({
		{
			"hrsh7th/nvim-cmp",
			cond = function()
				return not vim.g.vscode
			end,
			event = "InsertEnter",
			config = function()
				require("configs.autocmp").nvim_cmp()
			end,
			requires = {
				{
					"hrsh7th/cmp-nvim-lsp",
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-nvim-lua",
					after = "nvim-cmp",
				},
				{
					"saadparwaiz1/cmp_luasnip",
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-buffer",
					after = "nvim-cmp",
					config = function()
						require("configs.autocmp").cmp_buffer()
					end,
				},
				-- {
				-- 	"hrsh7th/cmp-cmdline",
				-- 	after = "nvim-cmp",
				-- 	config = function()
				-- 		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				-- 		local cmp = require("cmp")
				-- 		cmp.setup.cmdline(":", {
				-- 			sources = cmp.config.sources({
				-- 				{ name = "path" },
				-- 			}, {
				-- 				{ name = "cmdline" },
				-- 			}),
				-- 		})
				-- 	end,
				-- },
			},
		},
		{
			"L3MON4D3/LuaSnip",
			after = "nvim-cmp",
			config = function()
				require("luasnip.loaders.from_vscode").load()
				require("configs.autocmp").luasnip()
			end,
			requires = {
				"rafamadriz/friendly-snippets",
				after = { "nvim-cmp" },
			},
		},
		{
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("configs.autocmp").nvim_autopairs()
			end,
		},
		{
			"abecodes/tabout.nvim",
			wants = { "nvim-treesitter" }, -- or require if not used so far
			after = "nvim-cmp",
			config = function()
				require("configs.autocmp").tabout()
			end,
		},
	})
end)
