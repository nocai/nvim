vim.ui.select({ "a", "b", "c" }, {}, function (item, idx) 
	print(item)
	return item
end)
