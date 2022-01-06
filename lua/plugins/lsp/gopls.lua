return {
	cmd = { "gopls", "--remote=auto" },
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		analyses = {
			unreachable = true,
			unusedparams = true,
		},
		staticcheck = true,
	},
}
