local log = require("autoc.log")

local context = {}

function context:new(parent)
  setmetatable({}, {__index = self})

  self.parent = parent or {}

  -- (1,0)-indexed
  self.cursor = vim.api.nvim_win_get_cursor(0)

  self.current_line = vim.api.nvim_get_current_line()
  self.line_to_cursor = self.current_line:sub(1, self.cursor[2])

  -- Get the start position of the current keyword
  self.textMatch = vim.fn.match(self.line_to_cursor, "\\k*$")
  self.prefix = self.line_to_cursor:sub(self.textMatch + 1)

  -- log.print("context:", self)
  return self
end

return context
