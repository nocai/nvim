


local t = {"go", "java"}
t.tsserver = {"tsserver"}

for key, value in pairs(t) do
	print(type(key))
	print(key, value)
end
