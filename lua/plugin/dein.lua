local utils = require('utils')
local vim = vim

local dein_path = vim.g.home .. '/.cache/dein'
local dein_runtimepath = dein_path .. '/repos/github.com/Shougo/dein.vim'
local cmd_install = 'git clone https://github.com/Shougo/dein.vim ' .. dein_runtimepath

if not vim.o.runtimepath:match(dein_runtimepath) then
    if not utils.is_dir(dein_runtimepath) then
        os.execute(cmd_install)
    end
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. dein_runtimepath
end

if vim.fn['dein#load_state'](dein_path) == 1 then
    local tomls = io.popen('find "'.. vim.g.nvim_modules .. '" -name "*.toml"')
    vim.fn["dein#begin"](dein_path, vim.inspect(tomls:lines()))

    -- load plugs here
    vim.fn['dein#add'](dein_runtimepath)

    for file in tomls:lines() do
      vim.fn["dein#load_toml"](file)
    end

    vim.fn['dein#end']()
    vim.fn['dein#save_state']()

    if vim.fn['dein#check_install']() == 1 then
      vim.fn['dein#install']()
    end

    print("dein loading...")
end

vim.api.nvim_command('filetype plugin indent on')

if vim.fn.has('vim_starting') == 1 then
    vim.api.nvim_command('syntax enable')
end

vim.fn['dein#call_hook']('source')
vim.fn['dein#call_hook']('post_source')

