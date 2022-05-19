-- about UI
--
local ui = {}

function ui.sonokai()
	-- Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
	-- Default value: `'default'`
	vim.g.sonokai_style = "shusia"
	-- Available values: `'auto'`, `'red'`, `'orange'`, `'yellow'`, `'green'`, `'blue'`, `'purple'`
	-- Default value: `'auto'`
	vim.g.sonokai_cursor = "red"
	vim.g.sonokai_enable_italic = 1
	vim.g.sonokai_disable_italic_comment = 1
	vim.g.sonokai_transparent_background = 1
end

function ui.tokyonight()
	vim.g.tokyonight_italic_functions = true
	-- vim.g.tokyonight_style = "night"
	vim.g.tokyonight_italic_variables = true

	vim.g.tokyonight_transparent = true
	vim.g.tokyonight_transparent_sidebar = true
	vim.g.tokyonight_dark_float = false

	vim.g.tokyonight_hide_inactive_statusline = true
	vim.g.tokyonight_lualine_bold = true
	vim.g.tokyonight_terminal_colors = true

	vim.g.tokyonight_colors = { bg_float = "none" }
	-- vim.g.tokyonight_colors = { bg_highlight = "#2f3e42" }
end

function ui.nvim_tree()
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_highlight_opened_files = 3

	vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>")

	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				git_placement = "signcolumn",
			},
		},
		diagnostics = nvim.diagnostics,
		view = {
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
	-- auto close last windows in the tab
	vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
end

function ui.lualine()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
			-- section_separators = "",
			-- component_separators = "",
			-- section_separators = { left = "", right = "" },
			-- component_separators = { left = "", right = "" },
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					buffers_color = {
						-- Same values as the general color option can be used here.
						active = "lualine_a_normal", -- Color for active buffer.
						inactive = "lualine_b_normal", -- Color for inactive buffer.
					},
				},
			},
			lualine_z = { "tabs" },
		},
		extensions = { "nvim-tree", "quickfix", "toggleterm" },
	})
end

function ui.nvim_bufferline()
	require("bufferline").setup({
		options = {
			indicator_icon = "",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, _, _)
				if nvim.diagnostics.enable then
					local icon = level:match("error") and nvim.diagnostics.icons.error or nvim.diagnostics.icons.hint
					return icon .. " " .. count
				end
				return " " .. count
			end,
			offsets = { { filetype = "NvimTree", text = "Press g? for help", text_align = "left", padding = 1 } },
		},
	})
end
return ui
