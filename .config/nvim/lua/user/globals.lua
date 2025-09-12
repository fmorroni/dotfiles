P = function(obj)
  print(vim.inspect(obj))
  return obj
end

ScratchBuffer = function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(buf)
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

local path_separator = package.config:sub(1, 1) -- `/` on Unix, `\` on Windows

JoinPath = function(...)
  local parts = { ... }
  return table.concat(parts, path_separator)
end
