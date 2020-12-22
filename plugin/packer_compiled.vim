" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  LeaderF = {
    config = { "\27LJ\2\n∂\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0Ñ\5            let g:Lf_CommandMap = {'<c-k>': ['<c-e>'], '<c-j>': ['<c-n>']}\n\n            let g:Lf_WindowPosition = 'popup'\n            let g:Lf_PreviewInPopup = 1\n            let g:Lf_StlSeparator = { 'left': \"\\ue0b0\", 'right': \"\\ue0b2\" }\n            let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }\n\n            noremap <leader>fb :<C-U><C-R>=printf(\"Leaderf buffer %s\", \"\")<CR><CR>\n            noremap <leader>fm :<C-U><C-R>=printf(\"Leaderf mru %s\", \"\")<CR><CR>\n            noremap <leader>fl :<C-U><C-R>=printf(\"Leaderf line %s\", \"\")<CR><CR>\n            noremap <leader>fr :<C-U><C-R>=printf(\"Leaderf rg %s\", \"\")<CR><CR>\n          \14nvim_exec\bapi\bvim\0" },
    keys = { { "", "<leader>ff" }, { "", "<leader>fb" }, { "", "<leader>fm" }, { "", "<leader>fl" }, { "", "<leader>fr" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/LeaderF"
  },
  ["auto-pairs"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/auto-pairs"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\2\n¬\18\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0ê\18              let g:coc_snippet_next = '<TAB>'\n              let g:coc_snippet_prev = '<S-TAB>'\n              let g:snips_author = 'bucai'\n              let g:coc_global_extensions =[ 'coc-marketplace', 'coc-pairs', 'coc-snippets', 'coc-json', 'coc-lists', 'coc-stylelint', 'coc-yaml', 'coc-actions', 'coc-vimlsp', 'coc-vetur', 'coc-emmet', 'coc-prettier', 'coc-diagnostic' ]\n\n              autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')\n\n              inoremap <silent><expr> <TAB> pumvisible() ? \"<C-n>\" : v:lua.check_back_space() ? \"<TAB>\" : coc#refresh()\n              inoremap <expr><S-TAB> pumvisible() ? \"<C-p>\" : \"<C-h>\"\n\n              inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : \"<C-g>u<CR><c-r>=coc#on_enter()<CR>\"\n              inoremap <expr><C-e> pumvisible() ? \"<C-p>\" : \"<C-e>\"\n              \n              nmap <silent> [g <Plug>(coc-diagnostic-prev)\n              nmap <silent> ]g <Plug>(coc-diagnostic-next)\n\n              nmap <silent> gd <Plug>(coc-definition)\n              nmap <silent> gt <Plug>(coc-type-definition)\n              nmap <silent> gi <Plug>(coc-implementation)\n              nmap <silent> gr <Plug>(coc-references)\n\n              nmap <silent>rn <Plug>(coc-rename)\n              nmap <silent>ca <Plug>(coc-codeaction)\n              nmap <silent>fc <Plug>(coc-fix-current)\n\n              nnoremap <silent> <leader><leader>l  :<C-u>CocList<cr>\n              nnoremap <silent> <leader><leader>a  :<C-u>CocList diagnostics<cr>\n              nnoremap <silent> <leader><leader>e  :<C-u>CocList extensions<cr>\n              nnoremap <silent> <leader><leader>c  :<C-u>CocList commands<cr>\n              nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>\n              nnoremap <silent> <leader><leader>s  :<C-u>CocList -I symbols<cr>\n              nnoremap <silent> <leader><leader>n  :<C-u>CocNext<CR>\n              nnoremap <silent> <leader><leader>p  :<C-u>CocPrev<CR>\n              nnoremap <silent> <leader><leader>r  :<C-u>CocListResume<CR>\n\n              nnoremap <silent> K :call CocAction('doHover')<CR>\n\n              xmap uf <Plug>(coc-funcobj-i)\n              omap uf <Plug>(coc-funcobj-i)\n              xmap af <Plug>(coc-funcobj-a)\n              omap af <Plug>(coc-funcobj-a) \n            \14nvim_exec\bapi\bvim\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  ["lazygit.nvim"] = {
    config = { "\27LJ\2\nÂ\1\0\0\6\0\n\1\0176\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\0\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\17:LazyGit<CR>\15<leader>gg\6n\20nvim_set_keymap\bapi+lazygit_floating_window_scaling_factor%lazygit_floating_window_winblend\6g\bvimõ≥ÊÃ\25Ãô≥ˇ\3\0" },
    keys = { { "", "<leader>gg" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/lazygit.nvim"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n∑\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\22:LuaTreeClose<CR>\6q\1\0\2\fnoremap\2\vsilent\2\23:LuaTreeToggle<CR>\att\6n\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "", "tt" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["vim-quickrun"] = {
    config = { "\27LJ\2\nû\2\0\0\6\0\v\0\0196\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\0\0009\0\3\0009\0\t\0'\2\n\0+\3\1\0B\0\3\1K\0\1\0X            let g:quickrun_config = { \"_\" : { \"outputter\" : \"message\" }}\n          \14nvim_exec\1\0\2\fnoremap\1\vsilent\1\21<Plug>(quickrun)\15<leader>rr\6n\20nvim_set_keymap\bapi%quickrun_no_default_key_mappings\6g\bvim\0" },
    keys = { { "", "<leader>rr" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/vim-quickrun"
  },
  ["vim-surround"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/vim-surround"
  },
  ["vim-toml"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/liujun/.local/share/nvim/site/pack/packer/opt/vim-toml"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Config for: galaxyline.nvim
loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\feviline\frequire\0")()
-- Config for: rainbow
loadstring("\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\19rainbow_active\6g\bvim\0")()
-- Config for: vim-textobj-parameter
loadstring("\27LJ\2\n°\2\0\0\6\0\v\0%6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\t\0'\4\n\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\t\0'\4\n\0004\5\0\0B\0\5\1K\0\1\0 <Plug>(textobj-parameter-a)\aa,\6o <Plug>(textobj-parameter-i)\au,\6x\20nvim_set_keymap\bapi.textobj_parameter_no_default_key_mappings\6g\bvim\0")()
-- Config for: nvim-colorizer.lua
loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0")()
-- Config for: gruvbox
loadstring("\27LJ\2\n[\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\24colorscheme gruvbox\24set background=dark\bcmd\bvim\0")()
-- Config for: vim-textobj-indent
loadstring("\27LJ\2\nÃ\3\0\0\6\0\15\0E6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\t\0'\4\n\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\t\0'\4\n\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\v\0'\4\f\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\v\0'\4\f\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\r\0'\4\14\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\r\0'\4\14\0004\5\0\0B\0\5\1K\0\1\0\27<Plug>(textobj-same-a)\aaU\29<Plug>(textobj-indent-a)\aau\27<Plug>(textobj-same-i)\auU\6o\29<Plug>(textobj-indent-i)\auu\6x\20nvim_set_keymap\bapi+textobj_indent_no_default_key_mappings\6g\bvim\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads

" Keymap lazy-loads
noremap <silent> <leader>gg <cmd>call <SID>load(['lazygit.nvim'], { "keys": "<leader>gg", "prefix": "" })<cr>
noremap <silent> <leader>rr <cmd>call <SID>load(['vim-quickrun'], { "keys": "<leader>rr", "prefix": "" })<cr>
noremap <silent> <leader>fr <cmd>call <SID>load(['LeaderF'], { "keys": "<leader>fr", "prefix": "" })<cr>
noremap <silent> <leader>fm <cmd>call <SID>load(['LeaderF'], { "keys": "<leader>fm", "prefix": "" })<cr>
noremap <silent> <leader>fl <cmd>call <SID>load(['LeaderF'], { "keys": "<leader>fl", "prefix": "" })<cr>
noremap <silent> <leader>ff <cmd>call <SID>load(['LeaderF'], { "keys": "<leader>ff", "prefix": "" })<cr>
noremap <silent> tt <cmd>call <SID>load(['nvim-tree.lua'], { "keys": "tt", "prefix": "" })<cr>
noremap <silent> <leader>fb <cmd>call <SID>load(['LeaderF'], { "keys": "<leader>fb", "prefix": "" })<cr>

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType toml ++once call s:load(['vim-toml'], { "ft": "toml" })
  " Event lazy-loads
  au BufNewFile * ++once call s:load(['coc.nvim', 'vim-surround', 'auto-pairs'], { "event": "BufNewFile *" })
  au BufReadPre * ++once call s:load(['coc.nvim', 'vim-surround', 'auto-pairs'], { "event": "BufReadPre *" })
augroup END
