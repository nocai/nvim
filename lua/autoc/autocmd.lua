local autoc = require("autoc")
local log = require("autoc.log")

local autocmd = {
  autocs = {}
}

function autocmd.InsertCharPre(bufnr)
  log.print(">>> InsertCharPre", bufnr)
  autocmd.autocs[bufnr]:InsertCharPre()
end
function autocmd.CompleteDone(bufnr)
  log.print(">>> CompleteDone", bufnr)
  autocmd.autocs[bufnr]:CompleteDone()
end

function autocmd.attach(client, bufnr)
  autocmd.autocs[bufnr] = autoc:new(client, bufnr)

  vim.cmd(
    string.format(
      [[
				augroup autoc_group_%d
					au!
					autocmd InsertCharPre <buffer=%d> lua require("autoc.autocmd").InsertCharPre(%d)
					autocmd CompleteDone <buffer=%d> lua require("autoc.autocmd").CompleteDone(%d)
				augroup end
			]],
      bufnr,
      bufnr,
      bufnr,
      bufnr,
      bufnr
    )
  )
end
return autocmd
