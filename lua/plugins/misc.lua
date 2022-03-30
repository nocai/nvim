local misc = {}

table.insert(misc, {
	{
		"tweekmonster/startuptime.vim",
		cond = function()
			return not vim.g.vscode
		end,
		cmd = { "StartupTime" },
	},
	{
		"voldikss/vim-translator",
		cond = function()
			return not vim.g.vscode
		end,
		keys = { "<leader>tr" },
		config = function()
			vim.g.translator_default_engines = { "youdao", "bing" }
			vim.api.nvim_set_keymap("n", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("x", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
		end,
	},
	{
		"karb94/neoscroll.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				mappings = {
					"<C-u>",
					"<C-d>",
					"<C-b>",
					"<C-f>",
					"<C-y>",
					"zt",
					"zz",
					"zb",
				},
			})
			require("neoscroll.config").set_mappings({ ["<C-j>"] = { "scroll", { "0.10", "false", "100" } } })
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		event = "VimEnter",
		config = function()
			require("plugins.misc").toggleterm()
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
})

-- edit
table.insert(misc, {
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
			vim.cmd([[
				map ls <Plug>(textobj-sandwich-query-i)
				map ls <Plug>(textobj-sandwich-query-i)
				map as <Plug>(textobj-sandwich-query-a)
				map as <Plug>(textobj-sandwich-query-a)

				map lss <Plug>(textobj-sandwich-auto-i)
				map lss <Plug>(textobj-sandwich-auto-i)
				map ass <Plug>(textobj-sandwich-auto-a)
				map ass <Plug>(textobj-sandwich-auto-a)

				map lm <Plug>(textobj-sandwich-literal-query-i)
				map lm <Plug>(textobj-sandwich-literal-query-i)
				map am <Plug>(textobj-sandwich-literal-query-a)
				map am <Plug>(textobj-sandwich-literal-query-a)
		]])
		end,
	},
})

-- textobject
table.insert(misc, {
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
			vim.cmd([[
				xmap ll <Plug>(textobj-indent-i)
				omap ll <Plug>(textobj-indent-i)
				xmap lL <Plug>(textobj-indent-same-i)
				omap lL <Plug>(textobj-indent-same-i)

				xmap al <Plug>(textobj-indent-a)
				omap al <Plug>(textobj-indent-a)
				xmap aL <Plug>(textobj-indent-same-a)
				omap aL <Plug>(textobj-indent-same-a)
			]])
		end,
	},
	{
		"sgur/vim-textobj-parameter",
		after = { "vim-textobj-user" },
		setup = function()
			vim.g.textobj_parameter_no_default_key_mappings = 1
		end,
		config = function()
			vim.cmd([[
				xmap la <Plug>(textobj-parameter-i)
				omap la <Plug>(textobj-parameter-i)
				xmap aa <Plug>(textobj-parameter-a)
				omap aa <Plug>(textobj-parameter-a)
			]])
		end,
	},
})

function misc.toggleterm()
	require("toggleterm").setup({
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
		open_mapping = [[<C-\>]], -- mapping to <C-`>
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
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})
end

return misc
