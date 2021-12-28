local function nvim_cmp()
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
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "luasnip" },
			{ name = "nvim_lua" },
		},
	})
	-- vim.cmd([[ autocmd FileType lua lua require('cmp').setup.buffer { sources = { {name='nvim_lua'} } } ]])
end

local function lua_snip()
	local luasnip = require("luasnip")
	luasnip.config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
	})

	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				-- if is_pairs() then
				-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
				-- elseif luasnip.expand_or_jumpable() then
				if luasnip.expand_or_jumpable() then
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
				-- if is_pairs(true) then
				-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, true, true), "n", true)
				-- elseif luasnip.jumpable(-1) then
				if luasnip.jumpable(-1) then
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
						"",
						true
					)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})

	require("luasnip.loaders.from_vscode").load()
end

-- auto complete
return {
	{
		"hrsh7th/nvim-cmp",
		disable = vim.nv.is_vscode,
		event = "InsertEnter",
		config = nvim_cmp,
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
				requires = {
					{
						"L3MON4D3/LuaSnip",
						after = { "cmp_luasnip", "nvim-cmp" },
						config = lua_snip,
					},
				},
			},
		},
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
	{
		"rafamadriz/friendly-snippets",
		disable = vim.nv.is_vscode,
		event = "InsertEnter",
	},
}