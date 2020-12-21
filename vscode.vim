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

noremap e k
noremap E K
noremap <C-w>e <C-w>k

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

if exists('g:vscode')
    nnoremap <silent> <Leader>rr <Cmd>call VSCodeNotify('code-runner.run')<CR>

    " rename
    nnoremap <silent> rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>

    nnoremap <silent> gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
    nnoremap <silent> gT <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>

    nnoremap <silent> gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
    nnoremap <silent> gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>

    nnoremap <silent> gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
    " nnoremap <silent> gR <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>

    nnoremap <silent> <leader>fr <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

    
    " nnoremap <silent> <expr> <C-d> VSCodeExtensionCall('scroll', 'halfPage', 'down')
    " xnoremap <silent> <expr> <C-d> VSCodeExtensionCall('scroll', 'halfPage', 'down')
    " nnoremap <silent> <C-l> VSCodeExtensionCall('scroll', 'halfPage', 'up')
    " xnoremap <silent> <C-l> VSCodeExtensionCall('scroll', 'halfPage', 'up'
endif

