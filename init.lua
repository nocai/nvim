require("global")

if not vim.g.is_vscode then
    require("options").setup()
end

require("mappings").setup()

require("plugin.packer")
-- require("plugin.dein")
