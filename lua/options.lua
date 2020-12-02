local global = require("global")

-- From Lua you can work with editor |options| by reading and setting items in these Lua tables:
local options = {
  -- set editor options
  -- table: vim.o
  global = {
    mouse          = "a", -- all
    encoding       = "UTF-8",
    hidden         = true,

    wildignorecase = true,
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",

    pumheight      = 15,        -- Pop-up menu's line height
    pumwidth       = 15,        -- Pop-up menu's line width


    backup         = false,
    writebackup    = false,
    undofile       = false,
    swapfile       = false,
    undodir        = global.cache_dir .. "undo" .. global.path_sep,
    viewdir        = global.cache_dir .. "view" .. global.path_sep,
    backupdir      = global.cache_dir .. "backup" .. global.path_sep,
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",

    fileformats    = "unix,mac,dos",

    history        = 2000,

    smarttab       = true,
    shiftround     = true,

    timeout        = true,
    ttimeout       = true,
    timeoutlen     = 500,
    ttimeoutlen    = 0,
    updatetime     = 100,
    redrawtime     = 1500,

    ignorecase     = true,
    smartcase      = true,
    incsearch      = true,

    showmode       = false,
    shortmess      = "aoOTIcF",

    scrolloff      = 5,
    sidescrolloff  = 5,
    ruler          = false,
    list           = true,
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    showbreak      = "↳  ",

    -- autoread       = true, -- default it is
    autowrite      = true,
    autowriteall   = true,

    showtabline    = 2,
    laststatus     = 2,

    foldlevelstart = 99,

    termguicolors  = true,

    completeopt    = "menu,menuone,noselect,noinsert",

    -- window
    number         = true,
    relativenumber = true,

    foldenable     = true,
    foldmethod     = "indent",
    cursorline     = true,
    colorcolumn    = "88",
    signcolumn     = "yes",

    -- buffers
    fileencoding = "UTF-8",

    expandtab    = true,
    tabstop      = 4,
    shiftwidth   = 4,
    softtabstop  = -1,

    autoindent   = true,
  },

  -- set window-scoped local-options
  -- table: vim.wo
  window = {
    list           = true,
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",

    number         = true,
    relativenumber = true,

    foldenable     = true, -- set foldenable
    foldmethod     = "indent",

    cursorline     = true,
    colorcolumn    = "88",
    signcolumn     = "yes",
  },

  -- set buffer-scoped local-options
  -- table: vim.bo
  buffer = {
    fileencoding = "UTF-8",

    expandtab    = true,
    tabstop      = 4,
    shiftwidth   = 4,
    softtabstop  = -1,

    autoindent   = true,
  },
}

local function create_dirs()
  -- TODO: 判断一下是否需要创建 <19-09-20, lj.liujun> --
  local dirs = {
    options.undodir,
    options.viewdir,
    options.backupdir,
  }

  for _, dir in pairs(dirs) do
    if not global.is_dir(dir) then
      os.execute("mkdir -p " .. dir)
    end
  end
end

local function load_global_options()
  for option, value in pairs(options.global) do
    vim.o[option] = value
  end
end

local function load_window_option()
  for option, value in pairs(options.window) do
    vim.wo[option] = value
  end
end

local function load_buffer_option()
  for option, value in pairs(options.buffer) do
    vim.bo[option] = value
  end
end

local function load()
  -- create dirs: like undo, view, backup and so on
  create_dirs()

  -- load options
  load_global_options()
  load_window_option()
  load_buffer_option()
end

return {
  load = load,
}


