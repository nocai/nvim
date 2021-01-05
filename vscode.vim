let mapleader="\<space>"

" ===
" === Cursor Movement for colmark
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

noremap j e
noremap J E
noremap <C-j> <C-e>

noremap e k
noremap E K
noremap <C-w>e <C-w>k
noremap <C-e> 5k

noremap k n
noremap K N

noremap i l
noremap I L
noremap <C-w>i <C-w>l

noremap l i
noremap L I
noremap <C-l> <C-i>
