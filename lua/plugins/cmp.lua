local autoc = {}

table.insert(autoc, {
	{
		"hrsh7th/nvim-cmp",
		cond = function()
			return not vim.g.vscode
		end,
		event = "InsertEnter",
		config = function()
			require("plugins.cmp").cmp()
		end,
		requires = {
			{
				"hrsh7th/cmp-nvim-lsp",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-nvim-lua",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-buffer",
				after = "nvim-cmp",
			},
			{
				"saadparwaiz1/cmp_luasnip",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-cmdline",
				after = "nvim-cmp",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		config = function()
			local luasnip = require("luasnip")
			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

			require("plugins.cmp").luasnip()
			require("luasnip.loaders.from_vscode").load()
		end,
	},
	{
		"rafamadriz/friendly-snippets",
		after = "nvim-cmp",
	},
	{
		"onsails/lspkind-nvim",
		after = "nvim-cmp",
		config = function()
			require("cmp").setup({
				formatting = {
					format = require("lspkind").cmp_format({ with_text = true, maxwidth = 25 }),
				},
			})
		end,
	},
})

table.insert(autoc, {
	{
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("nvim-autopairs").setup({})
			local ok, cmp = pcall(require, "cmp")
			if ok then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			end
		end,
	},
	{
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = "nvim-cmp",
		config = function()
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
		end,
	},
})

function autoc.cmp()
	local cmp = require("cmp")
	cmp.setup({
		preselect = cmp.PreselectMode.None,
		-- completion = {
		--   keyword_length = 3
		-- },
		-- You must set mapping.
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-j>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			-- { name = 'vsnip' }, -- For vsnip users.
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = "buffer" },
		}),
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	-- cmp.setup.cmdline(":", {
	-- 	sources = cmp.config.sources({
	-- 		{ name = "path" },
	-- 	}, {
	-- 		{ name = "cmdline" },
	-- 	}),
	-- })
	-- vim.cmd([[ autocmd FileType lua lua require('cmp').setup.buffer { sources = { {name='nvim_lua'} } } ]])
end

function autoc.luasnip()
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").expand_or_jumpable() then
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						"",
						true
					)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if require("luasnip").jumpable(-1) then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "", true)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
end

return autoc
