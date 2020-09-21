local global = require("global")

function load()
  local dein_cache_dir = global.cache_dir .. 'dein'
  local dein_dir = global.cache_nvim_dir ..'dein/repos/github.com/Shougo/dein.vim'
  local cmd = "git clone https://github.com/Shougo/dein.vim " .. dein_dir

  if vim.fn.has('vim_starting') then
    vim.api.nvim_set_var('dein#auto_recache',1)
    vim.api.nvim_set_var('dein#install_max_processes',12)
    vim.api.nvim_set_var('dein#install_progress_type',"title")
    vim.api.nvim_set_var('dein#enable_notification',1)
    vim.api.nvim_set_var('dein#install_log_filename', dein_cache_dir .. global.path_sep ..'dein.log')

    if not string.match(vim.o.runtimepath,'/dein.vim') then
      if not global.is_dir(dein_dir) then
        os.execute(cmd)
      end
      vim.o.runtimepath = vim.o.runtimepath .. ',' .. dein_dir
    end
  end

  if vim.fn['dein#load_state'](dein_cache_dir) == 1 then
    local tomls = io.popen('find "'..global.modules_dir..'" -name "*.toml"')
    vim.fn["dein#begin"](dein_cache_dir, vim.inspect(tomls:lines()))

    -- load plugs here
    vim.fn['dein#add'](dein_dir)
    for file in tomls:lines() do
      vim.fn["dein#load_toml"](file)
    end

    vim.fn['dein#end']()
    vim.fn['dein#save_state']()

    if vim.fn['dein#check_install']() == 1 then
      vim.fn['dein#install']()
    end

    print("dein reload plugins......")
  end

  vim.api.nvim_command('filetype plugin indent on')

  if vim.fn.has('vim_starting') == 1 then
    vim.api.nvim_command('syntax enable')
  end

  vim.fn['dein#call_hook']('source')
  vim.fn['dein#call_hook']('post_source')
end


return {
  load = load,
}
