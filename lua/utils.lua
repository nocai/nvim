
local utils = {}

function utils.exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

function utils.is_dir(path) 
	return global.exists(path .. global.path_sep)
end

function utils.has_key(tbl, key)
	for idx, _ in pairs(tbl) do
		if idx == key then
			return true
		end
	end
	return false
end

function utils.has_value(tbl, value)
	for _, val in pairs(tbl) do
		if val == value then
			return true
		end
	end
	return false
end

function utils.readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

return utils
