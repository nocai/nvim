local m = {}
m["nvim/nvim-lspconfig"] = {
	event = "VimEnter",
	-- cond = function()
	-- 	return not vim.g.vscode
	-- end,
	-- config = function()
	-- 	m.Print()
	-- end,
}

function m.nvim_lspconfig()
	print("nvim_lspconfig")
end

local mm = {}

for name, spec in pairs(m) do
	print(name)
	print(type(spec))
	if type(spec) ~= "function" then
		print(vim.inspect(spec))
		-- self.repos[#self.repos+1] = vim.tbl_extend('force',{repo},conf)
		mm[#mm + 1] = vim.tbl_extend("force", { name }, spec)
	end
end

print(vim.inspect(mm))
return m
