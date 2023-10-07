P = function(obj)
  print(vim.inspect(obj))
  return obj
end

LogNewBuf = function(obj)
  local buf = vim.api.nvim_create_buf(true, false)
  print("Logging to buffer: " .. buf)
  local lines = {}
  for line in vim.inspect(obj):gmatch("([^\n]*)\n?") do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

CopyLineError = function()
  -- local errors = vim.lsp.diagnostic.get_line_diagnostics(nil, nil, nil, nil)
  local errors = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if (#errors == 0) then return end
  local msg = table.concat(vim.tbl_map(function(error) return error.message end, errors), "\n")
  vim.fn.setreg("+", msg)
end
