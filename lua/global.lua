local global = {
	home = os.getenv("HOME"),

	is_mac = jit.os == "OSX",
	is_linux = jit.os == "Linux",
	is_windows = jit.os == "Windows",
	is_vscode = vim.fn.exists('g:vscode') == 1

	-- path_sep = is_windows and "\\" or "/",
	-- -- nvim_path: ~/.config/nvim
	-- nvim_path = home .. path_sep .. ".config" .. path_sep .. "nvim",
	-- -- modules_dir: ~/.config/nvim/modules/
	-- modules_dir = nvim_path .. path_sep .. "modules" .. path_sep,
	-- -- cache_nvim_dir: ~/.cache/
	-- cache_dir = home .. path_sep .. ".cache" ..path_sep,
	-- -- cache_dir: ~/.cache/nvim/
	-- cache_nvim_dir = global.cache_dir .. "nvim" .. global.path_sep
}

function global.exists(file)
	local ok, err, code = os.rename(file, file)
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
