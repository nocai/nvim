require('global')
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
	return utils.exists(path .. vim.g.sep)
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

local function show_table(tbl, level)
    local show = ''
    local temp = ''

    level = level or 1
    local space = string.rep(' ', (level-1)*4)
    local sapce4 = string.rep(' ', 4)
    if(type(tbl) ~= 'table') then
        return 'error: params t is not a table.'
    else
        --取得表名
        show = show .. tostring(tbl) .. "{\n" .. space
        for k,v in pairs(tbl) do
            --递归显示table
            if type(v) == 'table' then
                temp = show_table(v, level+1)
            elseif(type(v) == 'string') then
                temp = '\"' .. tostring(v) .. '\"'
            else
                temp = tostring(v)
            end
            show = show .. sapce4 .. tostring(k) .. " = " .. temp .. ",\n" .. space
        end
        show = show .. "}"
    end
    return show
end

function utils.print_table(tbl, level)
    print(show_table(tbl, level))
end

return utils
