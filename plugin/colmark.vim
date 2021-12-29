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
nnoremap n          gj
nnoremap gn         gj
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
nnoremap e          gk
nnoremap ge         gk
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
tnoremap <Esc> <C-\><C-N>
tnoremap <M-N> <C-\><C-N><C-W>J
tnoremap <M-E> <C-\><C-N><C-W>K
tnoremap <M-H> <C-\><C-N><C-W>H
tnoremap <M-I> <C-\><C-N><C-W>L

nnoremap <c-s>      <cmd>wall<cr>
nnoremap <leader>lf <cmd>luafile %<cr>


if exists('g:vscode')
nnoremap rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap gD <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
nnoremap gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap gY <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap gq <Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>
nnoremap <leader><leader> <Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>

nnoremap E <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

nnoremap <C-l> <Cmd>call VSCodeNotify("workbench.action.navigateForward")<CR>

nnoremap H <Cmd>call <SID>moveCursor('top')<CR>
xnoremap H <Cmd>call <SID>moveCursor('top')<CR>
nnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
xnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
nnoremap I <Cmd>call <SID>moveCursor('bottom')<CR>
xnoremap I <Cmd>call <SID>moveCursor('bottom')<CR>

" Note: Using these in macro will break it
nnoremap ge <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap gn <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

" buffer management
nnoremap <C-w>k <Cmd>call <SID>splitNew('h', '__vscode_new__')<CR>
xnoremap <C-w>k <Cmd>call <SID>splitNew('h', '__vscode_new__')<CR>
" window navigation
nnoremap <C-w>n <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <C-w>n <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <C-w>e <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <C-w>e <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <C-w>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <C-w>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <C-w>i <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <C-w>i <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

nnoremap <C-w><C-n> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <C-w><C-n> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <C-w><C-e> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <C-w><C-e> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <C-w><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <C-w><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nnoremap <C-w><S-n> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
xnoremap <C-w><S-n> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
nnoremap <C-w><S-e> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
xnoremap <C-w><S-e> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
nnoremap <C-w><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
xnoremap <C-w><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
nnoremap <C-w><S-i> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
xnoremap <C-w><S-i> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
endif
