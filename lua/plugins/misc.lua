local function translator()
	vim.g.translator_default_engines = { "youdao", "bing" }
	vim.api.nvim_set_keymap("n", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("x", "<leader>tr", ":TranslateW<CR>", { silent = true, noremap = true })
end

local function sandwich()
	vim.cmd([[
			silent! omap <unique> lb <Plug>(textobj-sandwich-auto-i)
			silent! xmap <unique> lb <Plug>(textobj-sandwich-auto-i)
			silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
			silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

			silent! omap <unique> ls <Plug>(textobj-sandwich-query-i)
			silent! xmap <unique> ls <Plug>(textobj-sandwich-query-i)
			silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
			silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)

			silent! xmap <unique> l <Plug>(textobj-parameter-i)
			silent! xmap <unique> l2 <Plug>(textobj-parameter-greedy-i)
		]])
end

local function toggleterm()
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
		open_mapping = [[<C-Space>]], -- mapping to <C-`>
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
			winblend = 3,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})
end

local function neoscroll()
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

local function autosave_nvim()
	local autosave = require("autosave")
	autosave.setup({
		enabled = true,
		execution_message = "autosaved at : " .. vim.fn.strftime("%H:%M:%S"),
		events = { "InsertLeave", "TextChanged" },
		conditions = {
			exists = true,
			filetype_is_not = {},
			modifiable = true,
		},
		clean_command_line_interval = 2500,
		on_off_commands = true,
		write_all_buffers = false,
		debounce_delay = 5000,
	})
end

local function vim_matchup()
	local ok, config = pcall(require, "nvim-treesitter.configs")
	if ok then
		config.setup({
			matchup = {
				enable = true, -- mandatory, false will disable the whole extension
				-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
			},
		})
	end
end

-- misc
return {
	{
		"tweekmonster/startuptime.vim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		cmd = { "StartupTime" },
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VimEnter",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"kshenoy/vim-signature",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "VimEnter",
	},
	{
		"npxbr/glow.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		run = "GlowInstall",
		cmd = "Glow",
	},
	{
		"voldikss/vim-translator",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		keys = { "<leader>tr" },
		config = translator,
	},
	{
		"machakann/vim-sandwich",
		event = { "BufRead" },
		setup = function()
			vim.g.textobj_sandwich_no_default_key_mappings = 1
		end,
		config = sandwich,
	},
	{
		"karb94/neoscroll.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "WinScrolled",
		config = neoscroll,
	},
	{
		"akinsho/toggleterm.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "VimEnter",
		config = toggleterm,
	},
	{
		"Pocco81/AutoSave.nvim",
		cond = function()
			return vim.g.vscode ~= 1
		end,
		event = "VimEnter",
		config = autosave_nvim,
	},
	{
		"andymass/vim-matchup",
		config = vim_matchup,
		cond = function()
			return vim.g.vscode ~= 1
		end,
		setup = function()
			vim.cmd([[vmap l% <plug>(matchup-i%)]])
		end,
	},
	-- {
	-- 	"rhysd/accelerated-jk",
	-- 	event = { "BufRead" },
	-- 	setup = function()
	-- 		vim.cmd([[
	-- 			nmap <silent>n <Plug>(accelerated_jk_gj)
	-- 			nmap <silent>e <Plug>(accelerated_jk_gk)
	-- 		]])
	-- 	end,
	-- },
}
