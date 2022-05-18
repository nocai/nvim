local misc = {}

function misc.vim_translator()
	vim.g.translator_default_engines = { "youdao", "bing" }
	vim.api.nvim_set_keymap("n", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("x", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
end

function misc.neoscroll()
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
end

function misc.indent_blankline()
	vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_char = "┊"
	vim.g.indent_blankline_filetype_exclude = { "help", "packer", "nvimtree", "dashboard" }
	vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "packer" }
	vim.g.indent_blankline_char_highlight = "LineNr"
	vim.g.indent_blankline_show_trailing_blankline_indent = false
	vim.g.indent_blankline_show_first_indent_level = false
end

function misc.vim_sandwich()
	vim.cmd([[
		xmap ls <Plug>(textobj-sandwich-query-i)
		omap ls <Plug>(textobj-sandwich-query-i)
		xmap as <Plug>(textobj-sandwich-query-a)
		omap as <Plug>(textobj-sandwich-query-a)

		xmap lss <Plug>(textobj-sandwich-auto-i)
		omap lss <Plug>(textobj-sandwich-auto-i)
		xmap ass <Plug>(textobj-sandwich-auto-a)
		omap ass <Plug>(textobj-sandwich-auto-a)

		xmap lm <Plug>(textobj-sandwich-literal-query-i)
		omap lm <Plug>(textobj-sandwich-literal-query-i)
		xmap am <Plug>(textobj-sandwich-literal-query-a)
		omap am <Plug>(textobj-sandwich-literal-query-a)
	]])
end

function misc.vim_textobj_indent()
	vim.cmd([[
		xmap li <Plug>(textobj-indent-i)
		omap li <Plug>(textobj-indent-i)
		xmap lI <Plug>(textobj-indent-same-i)
		omap lI <Plug>(textobj-indent-same-i)

		xmap ai <Plug>(textobj-indent-a)
		omap ai <Plug>(textobj-indent-a)
		xmap aI <Plug>(textobj-indent-same-a)
		omap aI <Plug>(textobj-indent-same-a)
	]])
end

function misc.vim_textobj_parameter()
	vim.cmd([[
		xmap la <Plug>(textobj-parameter-i)
		omap la <Plug>(textobj-parameter-i)
		xmap aa <Plug>(textobj-parameter-a)
		omap aa <Plug>(textobj-parameter-a)
	]])
end

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
		-- size = function(term)
		-- 	if term.direction == "horizontal" then
		-- 		return 15
		-- 	elseif term.direction == "vertical" then
		-- 		return vim.o.columns * 0.4
		-- 	end
		-- end,
		open_mapping = [[<C-\>]], -- mapping to <C-`>
		-- hide_numbers = true, -- hide the number column in toggleterm buffers
		-- shade_filetypes = {},
		-- shade_terminals = true,
		-- shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		-- start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		-- persist_size = true,
		-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
		direction = "float",
		-- close_on_exit = true, -- close the terminal window when the process exits
		-- shell = vim.o.shell, -- change the default shell
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
				border = "FloatBorder",
				background = "Normal",
			},
		},
		-- TODO

		highlights = {
			-- NormalFloat = {
			-- link = "Normal",
			-- },
			FloatBorder = {
				guifg = "#3d59a1",
				-- guibg = "#24283b",
			},
		},
	})

	function _G.toggle_glow()
		local Terminal = require("toggleterm.terminal").Terminal
		local glow = Terminal:new({ cmd = "glow -p " .. vim.fn.expand("%"), hidden = true })
		glow:toggle()
	end
	-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua toggle_glow()<CR>", { noremap = true, silent = true })
	vim.cmd([[command! -nargs=? -complete=file Glow :lua toggle_glow()<CR>]])
end
return misc
