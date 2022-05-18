_G.nvim = {
	home = os.getenv("HOME") .. "/.config/nvim",

	is_mac = jit.os == "OSX",
	is_linux = jit.os == "Linux",
	is_vscode = vim.g.vscode == 1,
	is_not_vscode = vim.g.vscode ~= 1,

	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
}
