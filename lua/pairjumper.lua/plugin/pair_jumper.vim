if exists('g:pair_jumper_loaded') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! PairJumper lua require'pairjumper'.jump()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:pair_jumper_loaded = 1
