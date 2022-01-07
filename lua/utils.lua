local utils = {}

function utils.spce(module)
	local specs = {}

	local ok, mod = pcall(require, module)
	if not ok then
		return specs
	end

	for name, spec in pairs(mod) do
		if type(spec) == "table" then
			specs[#specs + 1] = vim.tbl_extend("force", { name }, spec)
		end
	end

	if #specs == 1 then
		return specs[1]
	end
	return specs
end

return utils
