local vim = vim

local global = require("global")

if global.is_mac then
  -- noremap Y "+y
  vim.api.nvim_set_keymap('', 'Y', '"+y', { noremap=true })
  vim.api.nvim_exec(
    [[
      set clipboard=unnamed
      let g:clipboard = { 'name': 'pbcopy', 'copy': { '+': 'pbcopy', '*': 'pbcopy', }, 'paste': { '+': 'pbpaste', '*': 'pbpaste', }, 'cache_enabled': 0 }
    ]],
  false)
end