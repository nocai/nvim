vim.g.home = os.getenv("HOME")
vim.g.nvim_home = vim.g.home .. "/.config/nvim"
vim.g.is_mac = jit.os == "OSX"
vim.g.is_linux = jit.os == "Linux"

-- disable distribution plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- v:lua
-- v:lua.check_back_space()
function _G.check_back_space()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- local ps = {"(", ")", "[", "]", "{", "}", "<", ">", "'", '"', "`"} -- , '.', ',', ';'}
local ps = {")", "]", "}", ">", "'", '"', "`"} -- , '.', ',', ';'}
function _G.is_pairs(shift)
  local col = vim.fn.col(".")

  if shift then
    col = col - 1
  end

  local c = vim.fn.getline("."):sub(col, col)

  for _, v in ipairs(ps) do
    if v == c then
      return true
    end
  end
  return false
end
