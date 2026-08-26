local gitsigns = require("gitsigns")

-- It doesn't work if file hasn't been loaded before.
---@type snacks.picker.Config
return {
  sort = { fields = { "file", "idx" } },
  actions = {
    diffview = function(picker, item)
      Snacks.picker.actions.jump(picker, item, {})
      vim.schedule(function()
        local buf = vim.api.nvim_get_current_buf()
        -- This tried to fix the unloaded file thing but doesn't work.
        vim.wait(1000, function() return vim.b[buf].gitsigns_status_dict ~= nil end, 20)
        vim.cmd.diffoff({ bang = true })
        gitsigns.diffthis("origin")
      end)
    end,
  },
  win = {
    input = {
      keys = {
        ["<c-d>"] = {
          "diffview",
          desc = "Diffview",
          mode = { "n", "i" },
        },
      },
    },
  },
  debug = {
    scores = true,
  },
}
