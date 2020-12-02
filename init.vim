let mapleader="\<space>"
" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     n
" < h   i >
"     e
"     v

noremap n j
noremap N J
noremap <C-w>n <C-w>j
noremap <C-n> 5j

noremap e k
noremap E K
noremap <C-w>e <C-w>k
noremap <C-e> 5k

noremap i l
noremap I L
noremap <C-w>i <C-w>l

noremap k n
noremap K N

noremap j e
noremap J E
noremap <C-j> <C-e>

noremap u i
noremap U I
noremap <C-u> <C-i>

noremap l u
noremap L U
noremap <C-l> <C-u>

" Resize splits with arrow keys
noremap <silent><up> :res +5<CR>
noremap <silent><down> :res -5<CR>
noremap <silent><left> :vertical resize-5<CR>
noremap <silent><right> :vertical resize+5<CR>

noremap R :source $MYVIMRC<CR>

nmap <silent><ESC> :nohlsearch<CR>

" 插件对python的依赖配置
" let g:python2_host_skip_check=1
" let g:python2_host_prog = '/usr/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'

" Disable vim distribution plugins
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

" let g:loaded_matchit = 1
" let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

lua require("core")

noremap Y "+y
set clipboard=unnamed
let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }


" 背景透明
" highlight Normal guibg=NONE ctermbg=None
