lua require("global")
lua require("mappings").setup()

if exists('g:vscode')
    finish " vscode暂时不加载插件
endif

lua require("options").setup()

call plug#begin('~/.vim/plugged')
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
let g:textobj_indent_no_default_key_mappings=1
xmap ll <Plug>(textobj-indent-i)
omap ll <Plug>(textobj-indent-i)
xmap lL <Plug>(textobj-indent-same-i)
omap lL <Plug>(textobj-indent-same-i)

xmap al <Plug>(textobj-indent-a)
omap al <Plug>(textobj-indent-a)
xmap aL <Plug>(textobj-indent-same-a)
omap aL <Plug>(textobj-indent-same-a)

Plug 'sgur/vim-textobj-parameter'
let g:textobj_parameter_no_default_key_mappings = 1
let g:vim_textobj_parameter_mapping = 'a'
xmap la <Plug>(textobj-parameter-i)
omap la <Plug>(textobj-parameter-i)
xmap aa <Plug>(textobj-parameter-a)
omap aa <Plug>(textobj-parameter-a)

Plug 'morhetz/gruvbox'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'glepnir/galaxyline.nvim'

Plug 'kyazdani42/nvim-tree.lua' ", { 'on': ['NvimTreeOpen','NvimTreeToggle'] }
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_width_allow_resize  = 1
let g:nvim_tree_show_icons = {
\ 'git': 1,
\ 'folders': 1,
\ 'files': 1,
\ }
nnoremap tt :NvimTreeOpen<CR>
nnoremap q :NvimTreeClose<CR>

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' ", { 'on': '<Plug>VSurround' }
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'kdheepak/lazygit.nvim', { 'on': 'LazyGit'}
let g:lazygit_floating_window_winblend = 0 
let g:lazygit_floating_window_scaling_factor = 0.9
nnoremap <silent><leader>gg :LazyGit<CR>

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:snips_author = 'bucai'
let g:coc_global_extensions =[ 'coc-marketplace', 'coc-snippets', 'coc-json', 'coc-lists', 'coc-stylelint', 'coc-yaml', 'coc-actions', 'coc-vimlsp', 'coc-vetur', 'coc-emmet', 'coc-prettier', 'coc-diagnostic' ]

autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

inoremap <silent><expr><TAB> v:lua.is_pairs() ? "<Right>" : pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()
inoremap <silent><expr><S-TAB> v:lua.is_pairs(v:true) ? "<Left>" : pumvisible() ? "<C-p>" : "<C-h>"

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
inoremap <expr><C-e> pumvisible() ? "<C-p>" : "<C-e>"

nmap <silent>[g <Plug>(coc-diagnostic-prev)
nmap <silent>]g <Plug>(coc-diagnostic-next)

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gD <Plug>(coc-declaration)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>rn <Plug>(coc-rename)

nmap <silent><leader>rf <Plug>(coc-refactor)
nmap <silent><leader>ac <Plug>(coc-codeaction)

nnoremap <silent><leader><leader>l  :<C-u>CocList<cr>
nnoremap <silent><leader><leader>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><leader><leader>e  :<C-u>CocList extensions<cr>
nnoremap <silent><leader><leader>c  :<C-u>CocList commands<cr>
nnoremap <silent><leader><leader>o  :<C-u>CocList outline<cr>
nnoremap <silent><leader><leader>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><leader><leader>n  :<C-u>CocNext<CR>
nnoremap <silent><leader><leader>p  :<C-u>CocPrev<CR>
nnoremap <silent><leader><leader>r  :<C-u>CocListResume<CR>

nnoremap <silent>gh :call CocActionAsync('doHover')<CR>

xmap lf <Plug>(coc-funcobj-i)
omap lf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a) 

call plug#end()

set background=dark
colorscheme gruvbox
lua require('galaxyline/eviline')
