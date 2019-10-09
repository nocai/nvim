call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'myusuf3/numbers.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'fatih/vim-go'

"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'iCyMind/NeoSolarized'
Plug 'google/vim-maktaba' " This is a dependency
Plug 'nfischer/vim-rainbows'
" //....


call plug#end()

set cursorline
set termguicolors
set ts=4
set sw=4
set expandtab
set autoindent
set ic


" ==========
" NeoSolarized Start
" =================
colorscheme NeoSolarized
" default value is "normal", Setting this option to "high" or "low" does use the 
" same Solarized palette but simply shifts some values up or down in order to 
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed 
" using ":set list" can be set to one of three levels depending on your needs. 
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"

" I make vertSplitBar a transparent background color. If you like the origin solarized vertSplitBar
" style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

" If you wish to enable/disable NeoSolarized from displaying bold, underlined or italicized 
" typefaces, simply assign 1 or 0 to the appropriate variable. Default values:  
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 0
set background=dark
" ==========
" NeoSolarized End
" =================

" ==========
" vim-go Start
" =================
let g:go_fmt_command = "goimports"
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
"colorscheme gruvbox
" ==========
" gruvbox Start
" ============

" ========
" COC Start
" ========
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

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
" ========
" COC End
" ========
