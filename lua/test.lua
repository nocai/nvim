local vim = vim
print("tsra")
-- print(vim.o.rtp)

local example_func = function(a, b)
    print('A is:', a)
    print('B is:', b)
end

example_func(1,2)
example_func(1)


local func_with_opts = function(opts)
    local will_do_foo = opts.foo
    print('wili_do_foo:', will_do_foo)
    local filename = opts.filename
    print('filename:', filename)
end

func_with_opts({foo = true, filename = "hello.world"})
func_with_opts{foo = false, filename = "hello.world2"}

vim.api.nvim_command('echo "Hello, Nvim!"')

print(_G.dump("tsra"))

print(vim.api.nvim_get_current_line())
print(vim.stricmp("abc", "ab"))
