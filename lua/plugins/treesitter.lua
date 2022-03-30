local treesitter = {}

-- treesitter
table.insert(treesitter, {
	"nvim-treesitter/nvim-treesitter",
	cond = function()
		return not vim.g.vscode
	end,
	event = { "BufRead", "BufNewFile" },
	-- run = ":TSUpdate",
	config = function()
		-- :TSInstall
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "go" },
			highlight = { enable = true, use_languagetree = true },
			incremental_selection = {
				enable = false,
				-- keymaps = {
				-- 	init_selection = "gnn",
				-- 	node_incremental = "grn",
				-- 	scope_incremental = "grc",
				-- 	node_decremental = "grm",
				-- },
			},
		})
		-- vim.api.nvim_command('set foldmethod=expr')
		-- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
	end,
})

table.insert(treesitter, {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
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
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["san"] = "@parameter.inner",
						},
						swap_previous = {
							["sap"] = "@parameter.inner",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						peek_definition_code = {
							["gpf"] = "@function.outer",
							["gpc"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter" },
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
		requires = { "nvim-treesitter/nvim-treesitter" },
		event = { "CursorMoved" },
		config = function()
			vim.cmd([[vmap l% <plug>(matchup-i%)]])
			require("nvim-treesitter.configs").setup({
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
				},
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
		after = { "nvim-treesitter" },
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false, -- for plugin: Comment.nvim
				},
			})
		end,
	},
})

return treesitter
