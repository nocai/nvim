vim.cmd "packadd packer.nvim"

local present, packer = pcall(require, "packer")

if not present then
  print "Cloning packer..."
  -- remove the dir before cloning
  vim.fn.delete(vim.nv.packer_path, "rf")
  vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    vim.nv.packer_path
  }

  vim.cmd "packadd packer.nvim"
  present, packer = pcall(require, "packer")

  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. vim.nv.packer_path .. "\n" .. packer)
  end
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {border = "single"}
    end,
    prompt_border = "single"
  },
  git = {
    clone_timeout = 6000, -- seconds
    default_url_format = "git@github.com:/%s"
  },
  auto_clean = true,
  compile_on_sync = true
}

return packer.startup(
  function(use)
    use {
      {
        "nvim-lua/plenary.nvim",
        disable = vim.nv.is_vscode
      },
      {
        "kyazdani42/nvim-web-devicons",
        disable = vim.nv.is_vscode
      },
      {
        "nanotee/nvim-lua-guide",
        disable = vim.nv.is_vscode
      },
      {
        "wbthomason/packer.nvim",
        disable = vim.nv.is_vscode,
        event = "VimEnter"
      },
      -- {
      --   "NvChad/nvim-base16.lua",
      --   after = "packer.nvim",
      --   config = function()
      --     require("colors").init(vim.nv.ui.theme)
      --   end
      -- }
    }

    use(require("plugins.misc"))
    use(require("plugins.ui"))
    use(require("plugins.cmp"))
    use(require("plugins.lspconfig"))
    use(require("plugins.telescope"))
    use(require("plugins.tools"))
    use(require("plugins.treesitter"))
    use(require("plugins.themes"))
  end
)
