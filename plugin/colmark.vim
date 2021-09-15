" ===
" === Cursor Movement for colmark
" ===
"     ^
"     n
" < h   i >
"     e
"     v

noremap <Space> <Nop>
let mapleader=' '
let maplocalleader = ' '

" nN => jJ {{{
" nnoremap n j
" nnoremap gn gj
nnoremap n          gj
nnoremap N          J
nnoremap gN         gJ
nnoremap <C-N>      <C-J>
nnoremap <C-W>n     <C-W>j
nnoremap <C-W><C-N> <C-W><C-J>

xnoremap n j
xnoremap N J

onoremap n j
onoremap N J
" }}}

" jJ => eE {{{
nnoremap j          e
nnoremap J          E
nnoremap gj         ge
nnoremap <C-J>      <C-E>
nnoremap <C-W>j     <C-W>e
nnoremap <C-W><C-J> <C-W><C-E>

xnoremap j  e
xnoremap J  E
xnoremap gj ge

onoremap j e
onoremap J E
" }}}

" eE => kK {{{
" nnoremap e k
" nnoremap ge gk
nnoremap e          gk
nnoremap E          K
nnoremap <C-E>      <C-K>
nnoremap <C-W>e     <C-W>k
nnoremap <C-W><C-E> <C-W><C-K>

xnoremap e k
xnoremap E K

onoremap e k
onoremap E K
" }}}

" kK => nN {{{
nnoremap k          n
nnoremap K          N
nnoremap gk         gn
nnoremap <C-K>      <C-N>
nnoremap <C-W>k     <C-W>n
nnoremap <C-W><C-K> <C-W><C-N>

xnoremap k  n
xnoremap K  N
xnoremap gk gn

onoremap k n
onoremap K N
" }}}

" iL => lL {{{
nnoremap i          l
nnoremap gi         gl
nnoremap I          L
nnoremap gI         gL
nnoremap <C-I>      <C-L>
nnoremap <C-W>i     <C-W>l
nnoremap <C-W><C-I> <C-W><C-L>

xnoremap i l
xnoremap I L

onoremap i l
onoremap I L
" }}}

" lL => iI {{{
nnoremap l          i
nnoremap gl         gi
nnoremap L          I
nnoremap gL         gI
nnoremap <C-L>      <C-I>
nnoremap <C-W>l     <C-W>i
nnoremap <C-W><C-L> <C-W><C-I>

xnoremap l i
xnoremap L I

onoremap l i
onoremap L I
" }}}

" {{{Resize splits with arrow keys
noremap <silent><up>    :res +5<CR>
noremap <silent><down>  :res -5<CR>
noremap <silent><left>  :vertical resize-5<CR>
noremap <silent><right> :vertical resize+5<CR>
" }}}

" buffers
nnoremap ]b :bnext<CR>
nnoremap ]B :blast<CR>
nnoremap [b :bprevious<CR>
nnoremap [B :bfirst<CR>

" terminal mode
tnoremap <M-N> <C-\><C-N><C-W>J
tnoremap <M-E> <C-\><C-N><C-W>K
tnoremap <M-H> <C-\><C-N><C-W>H
tnoremap <M-I> <C-\><C-N><C-W>L

nnoremap <c-s>      <cmd>wall<cr>
nnoremap <leader>lf <cmd>luafile %<cr>
