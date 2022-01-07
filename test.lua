local t = { "go", "java" }
t.tsserver = { "tsserver" }
t.a = "aa"


for key, value in pairs(t) do
	print(type(key))
	print(key, vim.inspect(value))
end

local tt = vim.tbl_deep_extend("force", t, { a = "a", b = "b" })
print(vim.inspect(tt))
