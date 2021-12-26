local function translator()
  vim.g.translator_default_engines = {"youdao", "bing"}
  vim.api.nvim_set_keymap("n", "<leader>tr", ":TranslateW<CR>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("x", "<leader>tr", ":TranslateW<CR>", {silent = true, noremap = true})
end

local function sandwich()
  vim.cmd(
    [[
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
		]]
  )
end

local function toggleterm()
  require("toggleterm").setup {
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
    open_mapping = [[<M-t>]],
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
        background = "Normal"
      }
    }
  }
end

local function neoscroll()
  require("neoscroll").setup {
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "zt",
      "zz",
      "zb"
    }
  }
  require("neoscroll.config").set_mappings({["<C-j>"] = {"scroll", {"0.10", "false", "100"}}})
end

-- misc
return {
  {
    "norcalli/nvim-colorizer.lua",
    disable = vim.nv.is_vscode,
    config = function()
      require "colorizer".setup()
    end
  },
  {
    "kshenoy/vim-signature",
    disable = vim.nv.is_vscode
  },
  {
    "npxbr/glow.nvim",
    disable = vim.nv.is_vscode,
    run = "GlowInstall",
    cmd = "Glow"
  },
  {
    "voldikss/vim-translator",
    disable = vim.nv.is_vscode,
    keys = {"<leader>tr"},
    config = translator
  },
  {
    "machakann/vim-sandwich",
    event = {"BufRead"},
    setup = function()
      vim.g.textobj_sandwich_no_default_key_mappings = 1
    end,
    config = sandwich
  },
  {
    "karb94/neoscroll.nvim",
    disable = vim.nv.is_vscode,
    event = "WinScrolled",
    config = neoscroll
  },
  {
    "akinsho/toggleterm.nvim",
    disable = vim.nv.is_vscode,
    config = toggleterm
  }
}
