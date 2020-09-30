-- local func_with_opts = function(opts)
--   local will_do_foo = opts.foo
--   local filename = opts.filename
--   print(will_do_foo)
--   print(filename)
-- end

-- func_with_opts({foo = true, filename = "hello.world"})
-- func_with_opts{foo = true, filename = "hello.world"}

-- print(tostring(vim.api.nvim_get_current_line()))

-- for k,v in pairs(vim.api.nvim_list_bufs()) do
--   print(k, v)
-- end

for k,v in pairs(vim.o) do
  print(k, v)
end
