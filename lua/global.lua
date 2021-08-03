local vim, jit = vim, jit

-- 直接将全局变量挂到vim.g上面
-- 方便其它地方使用
vim.g.is_mac = jit.os == "OSX"
vim.g.is_linux = jit.os == "Linux"
vim.g.is_windows = jit.os == "Windows"
vim.g.is_vscode = vim.fn.exists('g:vscode') == 1
vim.g.is_not_vscode = vim.fn.exists('g:vscode') ~= 1

vim.g.sep = vim.g.is_windows and [[\]] or '/'
vim.g.home = os.getenv("HOME")
vim.g.nvim_home = vim.g.home .. '/.config/nvim'

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

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

local ps = {'(',')', '[',']', '{','}', '<', '>', '\'', '"', '`', '.', ',', ';'}
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

