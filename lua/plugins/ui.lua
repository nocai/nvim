-- about ui
--
local ui = {}

table.insert(ui, {
	"norcalli/nvim-colorizer.lua",
	event = "VimEnter",
	cond = function()
		return vim.g.vscode ~= 1
	end,
	config = function()
		require("colorizer").setup()
	end,
})

-- ui
table.insert(ui, {
	{
		"lukas-reineke/indent-blankline.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		-- ft = { "lua" },
		config = function()
			require("plugins.ui").indent_blankline()
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		cond = function()
			return not vim.g.vscode
		end,
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.ui").nvim_tree()
		end,
	},
	{
		"hoob3rt/lualine.nvim",
		cond = function()
			return not vim.g.vscode
		end,
		event = { "VimEnter" },
		config = function()
			require("plugins.ui").lualine()
		end,
	},
	{
		"akinsho/nvim-bufferline.lua",
		cond = function()
			return not vim.g.vscode
		end,
		requires = { "kyazdani42/nvim-web-devicons" },
		event = { "VimEnter" },
		config = function()
			require("plugins.ui").nvim_bufferline()
		end,
	},
})

function ui.nvim_bufferline()
	local colors = {
		white = "#abb2bf",
		black = "#1e222a", --  nvim bg
		black2 = "#252931",
		grey_fg = "#565c64",
		light_grey = "#6f737b",
		red = "#d47d85",
		green = "#A3BE8C",
		lightbg = "#2d3139",
		lightbg2 = "#262a32",
	}

	require("bufferline").setup({
		options = {
			indicator_icon = "",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			-- separator_style = "thick",
			offsets = { { filetype = "NvimTree", text = "Press g? for help", text_align = "left", padding = 1 } },
		},
		highlights = {
			fill = {
				guifg = colors.grey_fg,
			},
			-- buffers
			buffer_visible = {
				guifg = colors.light_grey,
			},
			buffer_selected = {
				guifg = colors.white,
				gui = "bold",
			},
			-- tabs
			tab = {
				guifg = colors.light_grey,
			},
			tab_selected = {
				guifg = colors.black2,
			},
			tab_close = {
				guifg = colors.red,
			},
			indicator_selected = {
				guifg = colors.black,
			},
			-- separators
			separator = {
				guifg = colors.black2,
			},
			separator_visible = {
				guifg = colors.black2,
			},
			separator_selected = {
				guifg = colors.black2,
			},
			-- modified
			modified = {
				guifg = colors.red,
			},
			modified_visible = {
				guifg = colors.red,
			},
			modified_selected = {
				guifg = colors.green,
			},
			-- close buttons

			close_button = {
				guifg = colors.light_grey,
			},
			close_button_visible = {
				guifg = colors.light_grey,
			},
			close_button_selected = {
				guifg = colors.red,
			},
		},
	})
end

function ui.indent_blankline()
	vim.g.indent_blankline_char = "┊"
	vim.g.indent_blankline_filetype_exclude = { "help", "packer", "nvimtree", "dashboard" }
	vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "packer" }
	vim.g.indent_blankline_show_first_indent_level = false
	vim.g.indent_blankline_char_highlight = "LineNr"
	vim.g.indent_blankline_show_trailing_blankline_indent = false
end

function ui.lualine()
	local function lsp()
		local icon = [[  ]]
		local msg = "No Active LSP"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return icon .. msg
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return icon .. client.name
			end
		end

		return icon .. msg
	end

	local function progress_message()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = { "", "", "" }
			local success_icon = { "", "", "" }

			local ms = vim.loop.hrtime() / 1000000
			local frame = math.floor(ms / 120) % #spinners

			if percentage >= 70 then
				return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
			end

			return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
		end

		return ""
	end

	require("lualine").setup({
		options = {
			theme = vim.nv.ui.theme,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch" }, { "diff" } },
			lualine_c = {
				{ "filename" },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = vim.nv.diagnostics.icons.error .. " ",
						warn = vim.nv.diagnostics.icons.warning .. " ",
						info = vim.nv.diagnostics.icons.info .. " ",
					},
				},
				{ progress_message },
			},
			lualine_x = { { lsp } },
			lualine_y = { "encoding" },
			lualine_z = { { "progress" }, { "location" } },
		},
		extensions = { "nvim-tree" },
	})
end

function ui.nvim_tree()
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_highlight_opened_files = 3
	vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>", {
		noremap = true,
		silent = true,
	})
	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	require("nvim-tree").setup({
		open_on_setup = true,
		auto_close = true,
		disable_netrw = true,
		hijack_netrw = true,
		ignore_ft_on_setup = {},
		open_on_tab = false,
		hijack_cursor = true,
		update_cwd = false,
		update_to_buf_dir = {
			enable = false,
			auto_open = true,
		},
		diagnostics = {
			enable = vim.nv.diagnostics.enable,
			show_on_dirs = vim.nv.diagnostics.enable,
			icons = {
				hint = vim.nv.diagnostics.icons.hint,
				info = vim.nv.diagnostics.icons.info,
				warning = vim.nv.diagnostics.icons.warning,
				error = vim.nv.diagnostics.icons.error,
			},
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		system_open = {
			cmd = nil,
			args = {},
		},
		filters = {
			dotfiles = false,
			custom = {},
		},
		view = {
			auto_resize = true,
			mappings = {
				custom_only = true,
				list = {
					{ key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
					{ key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
					{ key = "<C-v>", cb = tree_cb("vsplit") },
					{ key = "<C-x>", cb = tree_cb("split") },
					{ key = "<C-t>", cb = tree_cb("tabnew") },
					{ key = "<", cb = tree_cb("prev_sibling") },
					{ key = ">", cb = tree_cb("next_sibling") },
					{ key = "P", cb = tree_cb("parent_node") },
					{ key = "<BS>", cb = tree_cb("close_node") },
					{ key = "<S-CR>", cb = tree_cb("close_node") },
					{ key = "<Tab>", cb = tree_cb("preview") },
					{ key = "E", cb = tree_cb("first_sibling") },
					{ key = "N", cb = tree_cb("last_sibling") },
					{ key = "L", cb = tree_cb("toggle_ignored") },
					{ key = "H", cb = tree_cb("toggle_dotfiles") },
					{ key = "R", cb = tree_cb("refresh") },
					{ key = "a", cb = tree_cb("create") },
					{ key = "d", cb = tree_cb("remove") },
					{ key = "r", cb = tree_cb("rename") },
					{ key = "<C-r>", cb = tree_cb("full_rename") },
					{ key = "x", cb = tree_cb("cut") },
					{ key = "c", cb = tree_cb("copy") },
					{ key = "p", cb = tree_cb("paste") },
					{ key = "y", cb = tree_cb("copy_name") },
					{ key = "Y", cb = tree_cb("copy_path") },
					{ key = "gy", cb = tree_cb("copy_absolute_path") },
					{ key = "[c", cb = tree_cb("prev_git_item") },
					{ key = "]c", cb = tree_cb("next_git_item") },
					{ key = "-", cb = tree_cb("dir_up") },
					{ key = "s", cb = tree_cb("system_open") },
					{ key = "q", cb = tree_cb("close") },
					{ key = "g?", cb = tree_cb("toggle_help") },
				},
			},
		},
	})
end

return ui
