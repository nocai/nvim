local function gitsigns()
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
			["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
			["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
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

local function quickrun()
	vim.g.quickrun_no_default_key_mappings = 1
	vim.g.quickrun_config = { _ = { outputter = "message" } }
	vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>(quickrun)", { noremap = false, silent = false })
end

local function test()
	vim.cmd([[
			let test#strategy = "neovim"
			nmap <silent> <leader>tt :TestNearest -v<CR>
			nmap <silent> <leader>tl :TestLast -v<CR>
			nmap <silent> <leader>tv :TestVisit<CR>
	]])
end

local function textobject_parameter()
	vim.cmd([[
			xmap la <Plug>(textobj-parameter-i)
			omap la <Plug>(textobj-parameter-i)
			xmap aa <Plug>(textobj-parameter-a)
			omap aa <Plug>(textobj-parameter-a)
		]])
end

local function formatter()
	require("formatter").setup({
		filetype = {
			-- luafmt
			lua = {
				function()
					return {
						exe = "luafmt",
						args = { "--indent-count", 2, "--stdin" },
						stdin = true,
					}
				end,
			},
		},
	})
end

local function autopairs()
	require("nvim-autopairs").setup({})

	local ok, cmp = pcall(require, "cmp")
	if ok then
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end
end

-- git
return {
	{
		"tpope/vim-fugitive",
		disable = vim.nv.is_vscode,
		cmd = { "G" },
	},
	{
		"lewis6991/gitsigns.nvim",
		disable = vim.nv.is_vscode,
		event = { "BufRead" },
		config = gitsigns,
	},
	{
		"thinca/vim-quickrun",
		disable = vim.nv.is_vscode,
		ft = { "go", "rust" },
		keys = "<leader>rr",
		config = quickrun,
	},
	{
		"vim-test/vim-test",
		disable = vim.nv.is_vscode,
		ft = { "go", "rust" },
		config = test,
	},
	{
		"sebdah/vim-delve",
		disable = vim.nv.is_vscode,
		cmd = "DlvToggleBreakpoint",
		config = function()
			vim.cmd([[nmap <leader>bb :DlvToggleBreakpoint<CR>]])
		end,
	},
	{
		"mhartington/formatter.nvim",
		disable = vim.nv.is_vscode,
		config = formatter,
	},
	{
		"terrortylor/nvim-comment",
		disable = vim.nv.is_vscode,
		event = "BufReadPre",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	-- textobject
	{
		"kana/vim-textobj-user",
		event = { "BufRead" },
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
		after = { "vim-textobj-user" },
		setup = function()
			vim.g.textobj_parameter_no_default_key_mappings = 1
		end,
		config = textobject_parameter,
	},
	{
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = autopairs,
	},
}
