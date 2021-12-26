-- return a table of available themes
local function list_themes(return_type)
  local themes = {}
  -- folder where theme files are stored
  local themes_folder = vim.fn.stdpath "data" .. "/site/pack/packer/opt/nvim-base16.lua/lua/hl_themes"
  print("folder", themes_folder)
  -- list all the contents of the folder and filter out files with .lua extension, then append to themes table
  local fd = vim.loop.fs_scandir(themes_folder)
  if fd then
    while true do
      local name, typ = vim.loop.fs_scandir_next(fd)
      if name == nil then
        break
      end
      if typ ~= "directory" and string.find(name, ".lua$") then
        -- return the table values as keys if specified
        if return_type == "keys_as_value" then
          themes[vim.fn.fnamemodify(name, ":r")] = true
        else
          table.insert(themes, vim.fn.fnamemodify(name, ":r"))
        end
      end
    end
  end
  return themes
end
--
-- reload a plugin ( will try to load even if not loaded)
-- can take a string or list ( table )
-- return true or false
local function reload_plugin(plugins)
  local status = true
  local function _reload_plugin(plugin)
    local loaded = package.loaded[plugin]
    if loaded then
      package.loaded[plugin] = nil
    end
    local ok, err = pcall(require, plugin)
    if not ok then
      print("Error: Cannot load " .. plugin .. " plugin!\n" .. err .. "\n")
      status = false
    end
  end

  if type(plugins) == "string" then
    _reload_plugin(plugins)
  elseif type(plugins) == "table" then
    for _, plugin in ipairs(plugins) do
      _reload_plugin(plugin)
    end
  end
  return status
end
-- reload themes without restarting vim
-- if no theme name given then reload the current theme
local function reload_theme(theme_name)
  -- if theme name is empty or nil, then reload the current theme
  if theme_name == nil or theme_name == "" then
    theme_name = vim.nv.ui.theme
  end

  if not pcall(require, "hl_themes." .. theme_name) then
    print("No such theme ( " .. theme_name .. " )")
    return false
  end

  vim.nv.ui.theme = theme_name

  -- reload the base16 theme and highlights
  require("colors").init(theme_name)

  -- TODO:
  -- if
  --   not reload_plugin {
  --     "plugins.configs.bufferline",
  --     "plugins.configs.statusline"
  --   }
  --  then
  --   print "Error: Not able to reload all plugins."
  --   return false
  -- end

  return true
end
--
-- clear command line from lua
local function clear_cmdline()
  vim.defer_fn(
    function()
      vim.cmd "echo"
    end,
    0
  )
end
-- 1st arg - r or w
-- 2nd arg - file path
-- 3rd arg - content if 1st arg is w
-- return file data on read, nothing on write
local function file_fn(mode, filepath, content)
   local data
   local fd = assert(vim.loop.fs_open(filepath, mode, 438))
   local stat = assert(vim.loop.fs_fstat(fd))
   if stat.type ~= "file" then
      data = false
   else
      if mode == "r" then
         data = assert(vim.loop.fs_read(fd, stat.size, 0))
      else
         assert(vim.loop.fs_write(fd, content, 0))
         data = true
      end
   end
   assert(vim.loop.fs_close(fd))
   return data
end

local function change_theme(current_theme, new_theme)
  if current_theme == nil or new_theme == nil then
    print "Error: Provide current and new theme name"
    return false
  end
  if current_theme == new_theme then
    return
  end

  local file = vim.fn.stdpath "config" .. "/lua/custom/" .. "chadrc.lua"

  -- store in data variable
  local data = assert(file_fn("r", file))
  -- escape characters which can be parsed as magic chars
  current_theme = current_theme:gsub("%p", "%%%0")
  new_theme = new_theme:gsub("%p", "%%%0")
  local find = "theme = .?" .. current_theme .. ".?"
  local replace = 'theme = "' .. new_theme .. '"'
  local content = string.gsub(data, find, replace)
  -- see if the find string exists in file
  if content == data then
    print("Error: Cannot change default theme with " .. new_theme .. ", edit " .. file .. " manually")
    return false
  else
    assert(file_fn("w", file, content))
  end
end
-- This file can be loaded as a telescope extension

-- Custom theme picker
-- uses nvchad_theme global variable
-- Most of the code is copied from telescope colorscheme plugin, mostly for preview creation
local function theme_switcher(opts)
  local pickers, finders, previewers, actions, action_state, utils, conf
  if pcall(require, "telescope") then
    pickers = require "telescope.pickers"
    finders = require "telescope.finders"
    previewers = require "telescope.previewers"

    actions = require "telescope.actions"
    action_state = require "telescope.actions.state"
    utils = require "telescope.utils"
    conf = require("telescope.config").values
  else
    error "Cannot find telescope!"
  end

  -- get a table of available themes
  local themes = list_themes()
  if next(themes) ~= nil then
    -- save this to use it for later to restore if theme not changed
    local current_theme = vim.nv.ui.theme
    local new_theme = ""
    local change = false

    -- buffer number and name
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    local previewer

    -- in case its not a normal buffer
    if vim.fn.buflisted(bufnr) ~= 1 then
      local deleted = false
      local function del_win(win_id)
        if win_id and vim.api.nvim_win_is_valid(win_id) then
          utils.buf_delete(vim.api.nvim_win_get_buf(win_id))
          pcall(vim.api.nvim_win_close, win_id, true)
        end
      end

      previewer =
        previewers.new {
        preview_fn = function(_, entry, status)
          if not deleted then
            deleted = true
            del_win(status.preview_win)
            del_win(status.preview_border_win)
          end
          reload_theme(entry.value)
        end
      }
    else
      -- show current buffer content in previewer
      previewer =
        previewers.new_buffer_previewer {
        define_preview = function(self, entry)
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
          local filetype = require("plenary.filetype").detect(bufname) or "diff"

          require("telescope.previewers.utils").highlighter(self.state.bufnr, filetype)
          reload_theme(entry.value)
        end
      }
    end

    local picker =
      pickers.new {
      prompt_title = "Set Color Scheme",
      finder = finders.new_table(themes),
      previewer = previewer,
      sorter = conf.generic_sorter(opts),
      attach_mappings = function()
        actions.select_default:replace(
          -- if a entry is selected, change current_theme to that
          function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            new_theme = selection.value
            change = true
            actions.close(prompt_bufnr)
          end
        )
        return true
      end
    }

    -- rewrite picker.close_windows
    local close_windows = picker.close_windows
    picker.close_windows = function(status)
      close_windows(status)
      -- now apply the theme, if success, then ask for default theme change
      local final_theme
      if change then
        final_theme = new_theme
      else
        final_theme = current_theme
      end

      if reload_theme(final_theme) then
        if change then
          -- ask for confirmation to set as default theme
          local ans = string.lower(vim.fn.input("Set " .. new_theme .. " as default theme ? [y/N] ")) == "y"
          clear_cmdline()
          if ans then
            change_theme(current_theme, final_theme)
          else
            -- will be used in restoring nvchad theme var
            final_theme = current_theme
          end
        end
      else
        final_theme = current_theme
      end
      -- set nvchad_theme global var
      vim.nv.ui.theme = final_theme
    end
    -- launch the telescope picker
    picker:find()
  else
    print("No themes found in " .. vim.fn.stdpath "config" .. "/lua/themes")
  end
end

-- register theme swticher as themes to telescope
local present, telescope = pcall(require, "telescope")
if present then
  return telescope.register_extension {
    exports = {
      themes = theme_switcher
    }
  }
else
  error "Cannot find telescope!"
end
