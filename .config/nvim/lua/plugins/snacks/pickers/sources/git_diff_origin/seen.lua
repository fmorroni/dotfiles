-- Tracks which files of the diff have already been reviewed.
-- A file is stored together with the hash of its diff, so if the diff changes
-- (new commits, rebase, local edits) the file automatically becomes "unseen" again.
-- State is persisted per git root so it survives restarts.

local M = {}

local path = vim.fn.stdpath("state") .. "/snacks_git_diff_seen.json"

---@type table<string, table<string, string>> root -> file -> diff hash
local state

local function load()
  if state then return state end
  local ok, data = pcall(function() return vim.json.decode(table.concat(vim.fn.readfile(path), "\n")) end)
  state = ok and type(data) == "table" and data or {}
  return state
end

local function save() vim.fn.writefile({ vim.json.encode(state) }, path) end

---@param item snacks.picker.Item
local function root(item) return item.cwd or vim.fn.getcwd() end

---@param item snacks.picker.Item
local function hash(item) return vim.fn.sha256(item.diff or "") end

---@param item snacks.picker.Item
function M.is_seen(item)
  local files = load()[root(item)]
  return files ~= nil and files[item.file] == hash(item)
end

---@param item snacks.picker.Item
---@param seen boolean
local function set(item, seen)
  local s = load()
  local r = root(item)
  s[r] = s[r] or {}
  s[r][item.file] = seen and hash(item) or nil
  if next(s[r]) == nil then s[r] = nil end
end

-- When marking a single item as seen, moves to the next item (`action.dir = -1` for previous,
-- `0` to stay on the current one).
---@param picker snacks.Picker
---@param action? snacks.picker.Action|{dir?: 1|0|-1}
function M.toggle_seen(picker, _, action)
  local dir = action and action.dir or 1
  local items = picker:selected({ fallback = true })
  if #items == 0 then return end
  -- If any of the items is unseen, mark all as seen. Otherwise unmark all.
  local mark = vim.iter(items):any(function(item) return not M.is_seen(item) end)
  for _, item in ipairs(items) do
    set(item, mark)
  end
  save()
  picker.list:set_selected()
  picker.list.dirty = true
  picker.list:update({ force = true })
  if mark and #items == 1 and dir ~= 0 then picker:action(dir == -1 and "list_up" or "list_down") end
end

---@param picker snacks.Picker
function M.clear_seen(picker)
  local item = picker:current()
  if not item then return end
  load()[root(item)] = nil
  save()
  picker.list.dirty = true
  picker.list:update({ force = true })
end

---@param item snacks.picker.Item
---@param picker snacks.Picker
function M.format(item, picker)
  local ret = require("snacks.picker.format").git_status(item, picker)
  local seen = M.is_seen(item)
  table.insert(ret, 1, { seen and "󰄬 " or "  ", "DiagnosticOk" })
  if seen then
    -- Dim the rest of the line.
    for i = 2, #ret do
      if type(ret[i][1]) == "string" then ret[i][2] = "Comment" end
    end
  end
  return ret
end

return M
