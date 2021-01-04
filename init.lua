require("global")

require("mappings").setup()

if not vim.g.is_vscode then
    require("options").setup()

    -- require("plugin.packer")
    require("plugin.dein")
end
