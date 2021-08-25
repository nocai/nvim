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

nnoremap n j
xnoremap n j
onoremap n j

nnoremap N J
xnoremap N J
onoremap N J

nnoremap <C-N>      <C-J>
nnoremap <C-W>n     <C-W>j
nnoremap <C-W><C-N> <C-W><C-J>

nnoremap j e
xnoremap j e
onoremap j e
nnoremap J E
xnoremap J E
onoremap J E
nnoremap <C-J>      <C-E>
nnoremap <C-W>j     <C-W>e
nnoremap <C-W><C-J> <C-W><C-E>

nnoremap e k
xnoremap e k
onoremap e k
nnoremap E K
xnoremap E K
onoremap E K
nnoremap <C-E>      <C-K>
nnoremap <C-W>e     <C-W>k
nnoremap <C-W><C-E> <C-W><C-K>

nnoremap k n
xnoremap k n
onoremap k n
nnoremap K N
xnoremap K N
onoremap K N
nnoremap <C-K>      <C-N>
nnoremap <C-W>k     <C-W>n
nnoremap <C-W><C-K> <C-W><C-N>

nnoremap i l
xnoremap i l
onoremap i l
nnoremap I L
xnoremap I L
onoremap I L
nnoremap <C-I>      <C-L>
nnoremap <C-W>i     <C-W>l
nnoremap <C-W><C-I> <C-W><C-L>

nnoremap l i
xnoremap l i
onoremap l i
nnoremap L I
xnoremap L I
onoremap L I
nnoremap <C-L>      <C-I>
nnoremap <C-W>l     <C-W>i
nnoremap <C-W><C-L> <C-W><C-I>

" insert mode
inoremap <C-K> <C-N>
inoremap <C-E> <C-P>
inoremap <C-J> <C-E>

" normal mode
nnoremap ]b :bnext<CR>
nnoremap ]B :blast<CR>
nnoremap [b :bprevious<CR>
nnoremap [B :bfirst<CR>

" terminal mode
tnoremap <M-N> <C-\><C-N><C-W>J
tnoremap <M-E> <C-\><C-N><C-W>K
tnoremap <M-H> <C-\><C-N><C-W>H
tnoremap <M-I> <C-\><C-N><C-W>L

