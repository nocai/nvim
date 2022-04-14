-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- 打开文件，光标回到上次编辑的位置
vim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

-- codelenses
-- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave lua vim.lsp.codelens.refresh()]])

vim.cmd([[autocmd ColorScheme * highlight FloatBorder guibg=None ctermbg=None]])
vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=None ctermbg=None]])
