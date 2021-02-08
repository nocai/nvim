require("global")
require("mappings").setup()
require("options").setup()

local vim = vim
local utils = require('utils')

local dein_dir = '~/.cache/deine'
local dein_path = dein_dir .. '/repos/github.com/Shougo/dein.vim'
local cmd_install = 'git clone https://github.com/Shougo/dein.vim ' .. dein_path
local toml_path = vim.g.nvim_home .. '/lua/internal'

-- auto install dein
if not vim.o.runtimepath:match(dein_dir) then
    if not utils.is_dir(dein_dir) then
        os.execute(cmd_install)
    end
    -- Add the dein installation directory into runtimepath
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. dein_path
end

if vim.fn['dein#load_state']('~/.cache/dein') == 1 then
    vim.fn["dein#begin"]('~/.cache/dein')

    -- load plugs here
    vim.fn['dein#add'](dein_path)

    local tomls = io.popen('find "'.. toml_path .. '" -name "*.toml"')
    for file in tomls:lines() do
      vim.fn["dein#load_toml"](file)
    end

    vim.fn['dein#end']()
    vim.fn['dein#save_state']()

    if vim.fn['dein#check_install']() == 1 then
      vim.fn['dein#install']()
    end
end

vim.api.nvim_command('filetype plugin indent on')

if vim.fn.has('vim_starting') == 1 then
    vim.api.nvim_command('syntax enable')
end

vim.fn['dein#call_hook']('source')
vim.fn['dein#call_hook']('post_source')

