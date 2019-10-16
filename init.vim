set hidden
set cursorline
set termguicolors
set ts=4
set sw=4
set expandtab
set autoindent
set ic

set scrolloff=5
"set showcmd
set hlsearch incsearch smartcase ignorecase

"noremap U 5k

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'myusuf3/numbers.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'fatih/vim-go'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
" LanguageServer client for NeoVim.
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })



" //....


call plug#end()






" ==========
" vim-go Start
" =================
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" ==========
" vim-go End
" =================

" ==========
" NERDTree Start
" =================
map <C-n> :NERDTreeToggle<CR>
" ==========
" NERDTree End
" =================

" ========
" airline Start
" ===========
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = ' > '
" ========
" airline End
" ===========


" ======
" Ack Start
" ==========
" cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" ======
" Ack End
" ==========

" =======
" Tagbar Start
" =======
" 安装tagbar插件
" 设置tagbar使用的ctags的插件,必须要设置对
" let g:tagbar_ctags_bin='/usr/bin/ctags'
" 设置tagbar的窗口宽度
let g:tagbar_width=30
" 设置tagbar的窗口显示的位置,为左边
let g:tagbar_right=1
"打开文件自动 打开tagbar
" autocmd BufReadPost *.go,*.c call tagbar#autoopen()
map tt :TagbarToggle<CR>
" =======
" Tagbar End
" =======


" ==========
" gruvbox Start
" ============
"let g:gruvbox_italic=1
"set background=dark
"let g:seoul256_background = 256
colorscheme gruvbox

" ========
" COC Start
" ========
" if hidden is not set, TextEdit might fail.
"set hidden

"" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

"" Better display for messages
"set cmdheight=2

"" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300

"" don't give |ins-completion-menu| messages.
"set shortmess+=c

"" always show signcolumns
"set signcolumn=yes

"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"" To make <cr> select the first completion item and confirm the completion when no item has been selected:
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

"" To make coc.nvim format your code on <cr>, use keymap:
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

<<<<<<< HEAD
"" Close the preview window when completion is done.
"autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
=======
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" To make coc.nvim format your code on <cr>, use keymap:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

>>>>>>> 505f04a3ffdd25bb322cec078fa5e0a44d56411f
" ========
" COC End
" ========
