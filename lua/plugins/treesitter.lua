local function treesitter()
	-- :TSInstall
	require("nvim-treesitter.configs").setup({
		indent = { enable = true },
		highlight = { enable = true },
		-- incremental_selection = {
		--   enable = true,
		--   keymaps = {
		--     init_selection = "gnn",
		--     node_incremental = "grn",
		--     scope_incremental = "grc",
		--     node_decremental = "grm"
		--   }
		-- }
	})
	-- vim.api.nvim_command('set foldmethod=expr')
	-- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
end

local function treesitter_textobjects()
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
end

-- treesitter
return {
	{
		"nvim-treesitter/nvim-treesitter",
		disable = vim.nv.is_vscode,
		event = { "BufRead" },
		run = ":TSUpdate",
		config = treesitter,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		disable = vim.nv.is_vscode,
		after = "nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = treesitter_textobjects,
	},
}
