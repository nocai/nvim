local function telescope()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			prompt_prefix = "  ",
			previewers = true,
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_next,
					["<C-e>"] = actions.move_selection_previous,
					["<C-l>"] = false,
					["<C-i>"] = actions.complete_tag,
				},
				n = {
					["j"] = false,
					["L"] = false,
					["n"] = actions.move_selection_next,
					["k"] = actions.move_selection_next,
					["p"] = actions.move_selection_previous,
					["e"] = actions.move_selection_previous,
					["I"] = actions.move_to_bottom,
				},
			},
		},
	})
	vim.api.nvim_set_keymap(
		"n",
		"<C-E>p",
		[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-p>",
		[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E>g",
		[[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-g>",
		[[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E>b",
		[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-b>",
		[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E>h",
		[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-h>",
		[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gs",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gr",
		[[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gi",
		[[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dd",
		[[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>wd",
		[[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap("n", "<leader>cs", [[<cmd>Telescope themes <CR>]], { noremap = true, silent = true })

	require("telescope").load_extension("themes")
end

local function telescope_fzf_native()
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = false, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})
	require("telescope").load_extension("fzf")
end

-- telescope
return {
	{
		"nvim-telescope/telescope.nvim",
		disable = vim.nv.is_vscode,
		keys = { "<C-E>" },
		config = telescope,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		disable = vim.nv.is_vscode,
		after = { "telescope.nvim" },
		run = "make",
		config = telescope_fzf_native,
	},
}
