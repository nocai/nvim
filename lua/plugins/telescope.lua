local telescope = {}

function telescope.keymap()
	vim.api.nvim_set_keymap("n", "<C-E><C-E>", [[<cmd>Telescope<CR>]], { noremap = true, silent = true })

	vim.api.nvim_set_keymap(
		"n",
		"<C-E>p",
		[[<cmd>lua require('telescope.builtin').find_files({})<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-p>",
		[[<cmd>lua require('telescope.builtin').find_files({})<CR>]],
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
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-h>",
		[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-E><C-R>",
		[[<cmd>lua require("telescope.builtin").resume()<CR>]],
		{ noremap = true, silent = true }
	)
end

-- telescope
table.insert(telescope, {
	"nvim-telescope/telescope.nvim",
	cond = function()
		return vim.g.vscode ~= 1
	end,
	event = { "VimEnter" },
	config = function()
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

		require("plugins.telescope").keymap()
	end,
})

-- telescope extensions
table.insert(telescope, {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		after = { "telescope.nvim" },
		run = "make",
		config = function()
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
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		after = { "telescope.nvim" },
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
})

return telescope
