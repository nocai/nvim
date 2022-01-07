local tools = {}

-- git
table.insert(tools, {
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
			require("plugins.tools").gitsigns()
		end,
	},
})

function tools.gitsigns()
	require("gitsigns").setup({
		current_line_blame = true,
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		keymaps = {
			noremap = true,
			["n ]h"] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
			["n [h"] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
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
			["x lh"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		},
	})
end

-- develop
table.insert(tools, {
	{
		"thinca/vim-quickrun",
		cond = function()
			return not vim.g.vscode
		end,
		ft = { "go", "rust" },
		keys = "<leader>rr",
		config = function()
			vim.g.quickrun_no_default_key_mappings = 1
			vim.g.quickrun_config = { _ = { outputter = "message" } }
			vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>(quickrun)", { noremap = false, silent = false })
		end,
	},
	{
		"vim-test/vim-test",
		cond = function()
			return not vim.g.vscode
		end,
		ft = { "go", "rust", "java" },
		config = function()
			vim.cmd([[
				let test#strategy = "neovim"
				nmap <silent> <leader>tt :TestNearest -v<CR>
				nmap <silent> <leader>tl :TestLast -v<CR>
				nmap <silent> <leader>tv :TestVisit<CR>
			]])
		end,
	},
	{
		"sebdah/vim-delve",
		cond = function()
			return not vim.g.vscode
		end,
		fg = { "go" },
		cmd = "DlvToggleBreakpoint",
		config = function()
			vim.cmd([[nmap <leader>bb :DlvToggleBreakpoint<CR>]])
		end,
	},
	{
		"numToStr/Comment.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	},
})


table.insert(tools, {
	"npxbr/glow.nvim",
	cond = function()
		return vim.g.vscode ~= 1
	end,
	run = "GlowInstall",
	cmd = "Glow",
})

return tools
