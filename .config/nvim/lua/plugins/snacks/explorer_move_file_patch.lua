---@module 'snacks'

local Tree = require("snacks.explorer.tree")

vim.schedule(function()
  local M = require("snacks.rename")

  -- Renames the provided file, or the current buffer's file.
  -- Prompt for the new filename if `to` is not provided.
  -- do the rename, and trigger LSP handlers
  ---@param opts? {from?: string, to?:string, force?:boolean, on_rename?: fun(to:string, from:string, ok:boolean)}
  M.rename_file = function(opts)
    opts = opts or {}
    local from = vim.fn.fnamemodify(opts.from or opts.file or vim.api.nvim_buf_get_name(0), ":p")
    local to = opts.to and vim.fn.fnamemodify(opts.to, ":p") or nil
    from, to = svim.fs.normalize(from), to and svim.fs.normalize(to) or nil
    local function rename()
      assert(to, "to is required")
      -- confirm override
      if not opts.force and vim.uv.fs_stat(to) ~= nil then
        local _, choice = pcall(vim.fn.confirm, ("Override '%s'?"):format(to), "&Yes\n&No\n&Cancel")
        if choice ~= 1 then
          return false
        end
      end
      M.on_rename_file(from, to, function()
        local ok = M._rename(from, to)
        if opts.on_rename then
          opts.on_rename(to, from, ok)
        end
      end)
    end
    if to then
      return rename()
    end
    local root = svim.fs.normalize(vim.fn.getcwd(0))
    if from:find(root, 1, true) ~= 1 then
      -- file is outside cwd, use its parent dir as root
      root = vim.fs.dirname(from)
    end
    local extra = from:sub(#root + 2)
    vim.ui.input({
      prompt = "New File Name: ",
      default = extra,
      completion = "file",
    }, function(value)
      if not value or value == "" or value == extra then
        return
      end
      to = svim.fs.normalize(root .. "/" .. value)
      rename()
    end)
  end

  --- Rename a file and update buffers
  ---@param from string
  ---@param to string
  ---@return boolean ok
  function M._rename(from, to)
    from = vim.fn.fnamemodify(from, ":p")
    to = vim.fn.fnamemodify(to, ":p")
    vim.fn.mkdir(vim.fs.dirname(to), "p") -- ensure target directory exists
    -- rename the file
    local ret = vim.fn.rename(from, to)
    if ret ~= 0 then
      Snacks.notify.error("Failed to rename file: `" .. from .. "`")
      return false
    end
    -- rename the buffer preserving changes/history
    local from_buf = vim.fn.bufnr(from)
    if not vim.api.nvim_buf_is_valid(from_buf) then
      return false
    end
    local to_buf = vim.fn.bufnr(to)
    if vim.api.nvim_buf_is_valid(to_buf) then
      vim.api.nvim_buf_delete(to_buf, { force = true })
    end
    vim.api.nvim_buf_set_name(from_buf, to)
    -- HACK: Sync the buffer to avoid the "Overwrite existing file?" prompt on save
    vim.api.nvim_buf_call(from_buf, function()
      local mod = vim.bo.modified
      vim.cmd("edit! | undo")
      vim.bo.modified = mod
    end)
    return true
  end
end)

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        explorer = {
          actions = {
            explorer_rename = function(picker, item)
              if not item then
                return
              end
              Snacks.rename.rename_file({
                from = item.file,
                on_rename = function(new, old, ok)
                  if ok then
                    Tree:refresh(vim.fs.dirname(old))
                    Tree:refresh(vim.fs.dirname(new))
                    picker:update({ target = new })
                  end
                end,
              })
            end,
            explorer_move = function(picker, item)
              ---@type string[]
              local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected())
              if #paths == 0 then
                Snacks.notify.warn("No files selected to move. Renaming instead.")
                local explorer_rename = Snacks.picker.config.action(picker, "explorer_rename")
                return explorer_rename(picker, picker:current())
              end
              local target = picker:dir()
              local what = #paths == 1 and vim.fn.fnamemodify(paths[1], ":p:~:.") or #paths .. " files"
              local t = vim.fn.fnamemodify(target, ":p:~:.")
              Snacks.picker.util.confirm("Move " .. what .. " to " .. t .. "?", function()
                for _, from in ipairs(paths) do
                  local to = target .. "/" .. vim.fn.fnamemodify(from, ":t")
                  Snacks.rename.rename_file({ from = from, to = to, force = true })
                  Tree:refresh(vim.fs.dirname(from))
                end
                Tree:refresh(target)
                picker.list:set_selected() -- clear selection
                picker:update({ target = target })
              end)
            end,
          },
        },
      },
    },
  },
}
