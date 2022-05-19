local autocmd = vim.api.nvim_create_autocmd

-- open nvim with a dir while still lazy loading nvimtree
-- autocmd("BufEnter", {
-- 	callback = function()
-- 		if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
-- 			vim.cmd("lcd %:p:h")
-- 		end
-- 	end,
-- })

-- Open a file from its last left off position
autocmd("BufReadPost", {
	callback = function()
		if not vim.fn.expand("%:p"):match(".git") and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
			-- vim.cmd("normal zz")
		end
	end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- codelenses
-- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave lua vim.lsp.codelens.refresh()]])

-- vim.cmd([[autocmd ColorScheme * highlight FloatBorder guibg=None ctermbg=None]])
-- vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=None ctermbg=None]])

