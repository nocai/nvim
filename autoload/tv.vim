function tv#Func1()
   echo "Done!"
endfunction

function! tv#CurrentLineInfo()
lua << EOF
   local linenr = vim.api.nvim_win_get_cursor(0)[1]
   local curline = vim.api.nvim_buf_get_lines(
         0, linenr, linenr + 1, false)[1]
   print(string.format("Current line [%d] has %d bytes",
         linenr, #curline))
EOF
endfunction
