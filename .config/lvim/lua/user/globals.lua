P = function(obj)
  print(vim.inspect(obj))
  return obj
end

local function LogNewBuf(lines)
  local buf = vim.api.nvim_create_buf(true, true)
  print("Logging to buffer: " .. buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_current_buf(buf)
end


LogObj = function(obj)
  local lines = {}
  for line in vim.inspect(obj):gmatch("([^\n]*)\n?") do
    table.insert(lines, line)
  end
  LogNewBuf(lines)
end

LogMessages = function()
  local messages = vim.split(vim.api.nvim_cmd({ cmd = 'mes' }, { output = true }), '\n')
  LogNewBuf(messages)
end

CopyLineError = function()
  -- local errors = vim.lsp.diagnostic.get_line_diagnostics(nil, nil, nil, nil)
  local errors = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if (#errors == 0) then return end
  local msg = table.concat(vim.tbl_map(function(error) return error.message end, errors), "\n")
  vim.fn.setreg("+", msg)
end
