local global = {
	home = os.getenv("HOME"),

	is_mac = jit.os == "OSX",
	is_linux = jit.os == "Linux",
	is_windows = jit.os == "Windows",
}

global.path_sep = global.is_windows and "\\" or "/"
-- nvim_path: ~/.config/nvim
global.nvim_path = global.home .. global.path_sep .. ".config" .. global.path_sep .. "nvim"
-- modules_dir: ~/.config/nvim/modules/
global.modules_dir = global.nvim_path .. global.path_sep .. "modules" .. global.path_sep
-- cache_nvim_dir: ~/.cache/
global.cache_dir = global.home .. global.path_sep .. ".cache" .. global.path_sep
-- cache_dir: ~/.cache/nvim/
global.cache_nvim_dir = global.cache_dir .. "nvim" .. global.path_sep

function global.exists(file) 
	local ok, err, code = os.remove(file, file)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

function global.is_dir(path) 
	return global.exists(path .. global.path_sep)
end

function global.has_key(tbl, key)
	for idx, _ in pairs(tbl) do
		if idx == key then
			return true
		end
	end
	return false
end

function global.has_value(tbl, value)
	for _, val in pairs(tbl) do
		if val == value then
			return true
		end
	end
	return false
end

function global.readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

return global
