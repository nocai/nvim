vim.g.home = os.getenv("HOME")
vim.g.nvim_home = vim.g.home..'/.config/nvim'
vim.g.is_macOS = jit.os == "OSX"
vim.g.is_linux = jit.os == "Linux"

-- v:lua
-- v:lua.check_back_space()
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
  else
		return false
  end
end

local ps = {'(',')', '[',']', '{','}', '<', '>', '\'', '"', '`'} -- , '.', ',', ';'}
function _G.is_pairs(shift)
	local col = vim.fn.col('.')

	if shift then
			col = col - 1
	end

	local c = vim.fn.getline('.'):sub(col, col)

	for _, v in ipairs(ps) do
			if v == c then
					return true
			end
	end
	return false
end
