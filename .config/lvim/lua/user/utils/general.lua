local M = {}

local function getPos(s)
  local p = vim.fn.getcharpos(s)
  return { p[2], p[3] }
end

local function getPos0Indexed(s)
  local p = getPos(s)
  return { p[1] - 1, p[2] - 1 }
end

local function comparePos(pos1, pos2)
  if (pos1[1] < pos2[1]) then
    return -1
  elseif (pos1[1] > pos2[1]) then
    return 1
  elseif (pos1[2] < pos2[2]) then
    return -1
  elseif (pos1[2] > pos2[2]) then
    return 1
  else
    return 0
  end
end

M.get_visual_selection = function()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    P('Operation cancelled, mode: ' .. mode)
    return
  end
  local pos1 = getPos0Indexed('v')
  local pos2 = getPos0Indexed('.')
  local posComp = comparePos(pos1, pos2)
  local posStart = (posComp <= 0) and pos1 or pos2
  local posEnd = (posComp <= 0) and pos2 or pos1
  if mode == "\22" then mode = "\22" .. (posEnd[2] - posStart[2]) end
  local region = vim.region(0, posStart, posEnd, mode, false)
  local lines = {}
  for lineNbr, pos in pairs(region) do
    local line = vim.api.nvim_buf_get_lines(0, lineNbr, lineNbr + 1, false)[1]:sub(
      (pos[1] > -1) and pos[1] + 1 or -1,
      (pos[2] > -1) and pos[2] + 1 or -1
    )
    -- P({ lineNbr, line, pos })
    table.insert(lines, line)
  end
  local p = table.concat(lines, '\n')
  -- P(p)
  return p
end



local action_state = require('telescope.actions.state')
local actions = require "telescope.actions"

M.get_telescope_selected_filesnames = function(bufnr)
  local current_picker = action_state.get_current_picker(bufnr)
  local entries = current_picker:get_multi_selection()
  local files = {}
  for _, entry in pairs(entries) do
    table.insert(files, entry[1])
  end
  if #files == 0 then
    table.insert(files, action_state.get_selected_entry()[1])
  end
  return files
end

return M
