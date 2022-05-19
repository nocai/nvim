local autocmp = {
	lspkind_icon = {
		Class = " ",
		Color = " ",
		Constant = "ﲀ ",
		Constructor = " ",
		Enum = "練",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = "",
		Folder = " ",
		Function = " ",
		Interface = "ﰮ ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Operator = "",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = "塞",
		Value = " ",
		Variable = " ",
	},
}

function autocmp.nvim_cmp()
	local cmp = require("cmp")
	cmp.setup({
		-- preselect = cmp.PreselectMode.None,
		-- completion = {
		--   keyword_length = 3
		-- },
		window = {
			completion = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			},
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			},
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			duplicates_default = 0,
			format = function(entry, vim_item)
				vim_item.kind = autocmp.lspkind_icon[vim_item.kind]

				local maxwidth = 30
				if string.len(vim_item.abbr) > maxwidth then
					vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth) .. "…"
				end

				local source_names = {
					nvim_lsp = "(LSP)",
					nvim_lua = "(NvLua)",
					emoji = "(Emoji)",
					path = "(Path)",
					calc = "(Calc)",
					cmp_tabnine = "(Tabnine)",
					vsnip = "(Snippet)",
					luasnip = "(Snippet)",
					buffer = "(Buffer)",
				}
				vim_item.menu = source_names[entry.source.name]

				local duplicates = {
					buffer = 1,
					path = 1,
					nvim_lsp = 0,
					luasnip = 1,
				}
				vim_item.dup = duplicates[entry.source.name]
				return vim_item
			end,
		},
		-- You must set mapping.
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-k>"] = cmp.mapping.select_next_item(),
			["<C-e>"] = cmp.mapping.select_prev_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-j>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			-- { name = 'vsnip' }, -- For vsnip users.
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = "buffer" },
		}),
		experimental = {
			native_menu = false,
			ghost_text = true,
		},
	})
	-- vim.cmd([[ autocmd FileType lua lua require('cmp').setup.buffer { sources = { {name='nvim_lua'} } } ]])
end

function autocmp.cmp_buffer()
	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	local cmp = require("cmp")
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})
end

function autocmp.luasnip()
	require("luasnip.config").setup({
		region_check_events = "InsertEnter",
	})

	local present, cmp = pcall(require, "cmp")
	if not present then
		return
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
end

function autocmp.nvim_autopairs()
	require("nvim-autopairs").setup({})
	local ok, cmp = pcall(require, "cmp")
	if ok then
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end
end

function autocmp.tabout()
	require("tabout").setup({
		tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
		backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
		act_as_tab = true, -- shift content if tab out is not possible
		act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
		enable_backwards = true, -- well ...
		completion = true, -- if the tabkey is used in a completion pum
		tabouts = {
			{ open = "'", close = "'" },
			{ open = '"', close = '"' },
			{ open = "`", close = "`" },
			{ open = "(", close = ")" },
			{ open = "[", close = "]" },
			{ open = "{", close = "}" },
		},
		ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
		exclude = {}, -- tabout will ignore these filetypes
	})
end

return autocmp
