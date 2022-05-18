local misc = {}

function misc.vim_translator()
	vim.g.translator_default_engines = { "youdao", "bing" }
	vim.keymap.set({ "n", "x" }, "<leader>tr", ":TranslateW<CR>")
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
	vim.keymap.set({ "x", "o" }, "ls", "<Plug>(textobj-sandwich-query-i)")
	vim.keymap.set({ "x", "o" }, "as", "<Plug>(textobj-sandwich-query-a)")

	vim.keymap.set({ "x", "o" }, "lss", "<Plug>(textobj-sandwich-auto-i)")
	vim.keymap.set({ "x", "o" }, "ass", "<Plug>(textobj-sandwich-auto-a)")

	vim.keymap.set({ "x", "o" }, "lm", "<Plug>(textobj-sandwich-literal-query-i)")
	vim.keymap.set({ "x", "o" }, "am", "<Plug>(textobj-sandwich-literal-query-a)")
end

function misc.vim_textobj_indent()
	vim.keymap.set({ "x", "o" }, "li", "<Plug>(textobj-indent-i)")
	vim.keymap.set({ "x", "o" }, "lI", "<Plug>(textobj-indent-same-i)")

	vim.keymap.set({ "x", "o" }, "ai", "<Plug>(textobj-indent-a)")
	vim.keymap.set({ "x", "o" }, "aI", "<Plug>(textobj-indent-same-a)")
end

function misc.vim_textobj_parameter()
	vim.keymap.set({ "x", "o" }, "la", "<Plug>(textobj-parameter-i)")
	vim.keymap.set({ "x", "o" }, "aa", "<Plug>(textobj-parameter-a)")
end

function misc.toggleterm()
	require("toggleterm").setup({
		open_mapping = [[<C-\>]], -- mapping to <C-`>
		direction = "float",
		float_opts = {
			border = "curved",
		},
		highlights = {
			FloatBorder = {
				link = "FloatBorder",
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
