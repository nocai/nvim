if exists('g:vscode')
nnoremap <space><space> <Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>

nnoremap ga <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap gq <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap go <Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>

nnoremap gn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap gY <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

nnoremap E <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

nnoremap <C-l> <Cmd>call VSCodeNotify("workbench.action.navigateForward")<CR>

function s:moveCursor(to)
    " Native VSCode commands don't register jumplist. Fix by registering jumplist in Vim e.g. for subsequent use of <C-o>
    normal! m'
    call VSCodeExtensionNotify('move-cursor', a:to)
endfunction
nnoremap H <Cmd>call <SID>moveCursor('top')<CR>
xnoremap H <Cmd>call <SID>moveCursor('top')<CR>
nnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
xnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
nnoremap I <Cmd>call <SID>moveCursor('bottom')<CR>
xnoremap I <Cmd>call <SID>moveCursor('bottom')<CR>

" Note: Using these in macro will break it
" nnoremap ge <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
" nnoremap gn <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

function! s:split(...) abort
    let direction = a:1
    let file = exists('a:2') ? a:2 : ''
    call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if !empty(file)
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, empty(file) ? '__vscode_new__' : file)
endfunction
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

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

function! s:vscodePrepareMultipleCursors(append, skipEmpty)
    let m = mode()
    if m ==# 'V' || m ==# "\<C-v>"
        let b:notifyMultipleCursors = 1
        let b:multipleCursorsVisualMode = m
        let b:multipleCursorsAppend = a:append
        let b:multipleCursorsSkipEmpty = a:skipEmpty
        " We need to start insert, then spawn cursors otherwise they'll be destroyed
        " using feedkeys() here because :startinsert is being delayed
        call feedkeys("\<Esc>i", 'n')
    endif
endfunction
" Multiple cursors support for visual line/block modes
xnoremap ma <Cmd>call <SID>vscodePrepareMultipleCursors(1, 1)<CR>
xnoremap mA <Cmd>call <SID>vscodePrepareMultipleCursors(1, 0)<CR>

xnoremap mi <Nop>
xnoremap mI <Nop>
xnoremap ml <Cmd>call <SID>vscodePrepareMultipleCursors(0, 1)<CR>
xnoremap mL <Cmd>call <SID>vscodePrepareMultipleCursors(0, 0)<CR>
endif
