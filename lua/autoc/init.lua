local context = require("autoc.context")
local cache = require("autoc.cache")
local log = require("autoc.log")

local autoc = {
  client = nil,
  bufnr = -1,
  cache = nil,
  ctx = nil
}

function autoc:new(client, bufnr)
  setmetatable({}, self)
  self.__index = self
  self.client = client
  self.bufnr = bufnr
  self.cache = cache.new()

  self.__tostring = function()
    return vim.tbl_keys(self)
  end
  return self
end

function autoc:InsertCharPre()
  if vim.fn.pumvisible() == 1 then
    log.print("filter")
    return
  end

  local timer = vim.loop.new_timer()
  timer:start(
    1000,
    0,
    vim.schedule_wrap(
      function()
        timer:stop()
        timer:close()
        self:completion()
      end
    )
  )
end

function autoc:completion()
  log.print("completion()")

  self.cache:ensure(
    {"completion", self.bufnr},
    function()
      local callback = function(result)
        self.ctx = context:new(self.ctx)

        -- convert to nvim complete items
        local matches = vim.lsp.util.text_document_completion_list_to_complete_items(result, self.ctx.prefix)

        vim.fn.complete(self.ctx.textMatch + 1, matches)
      end
      self:do_completion(callback)
    end
  )
end

function autoc:do_completion(callback)
  log.print("do_completion()")

  self.client.request(
    "textDocument/completion",
    vim.lsp.util.make_position_params(),
    function(err, _, result)
      if err then
        log.print(vim.inspect(err))
        return
      elseif not result then
        return
      end

      local mode = vim.api.nvim_get_mode()["mode"]
      if mode == "i" or mode == "ic" then
				callback(result)
      end
    end
  )
end

function autoc:CompleteDone()
  local completed_item = vim.v.completed_item
  if not completed_item or not completed_item.user_data then
    return
  end

  -- local item = completed_item.user_data
  local item = completed_item.user_data.nvim.lsp.completion_item
  if item.insertTextFormat == 2 then
    -- Remove the already inserted word
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    local line = vim.api.nvim_get_current_line()
    local suffix = line:sub(col + 1)

    local start_char = col - #completed_item.word
    vim.api.nvim_buf_set_text(self.bufnr, row - 1, start_char, row - 1, #line, {})

    -- expand snippet
    if item.textEdit then
      require("luasnip").lsp_expand(item.textEdit.newText .. suffix)
    elseif item.insertText then
      require("luasnip").lsp_expand(item.insertText .. suffix)
    end
  end
end

return autoc
