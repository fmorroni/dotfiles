-- Adapted from https://github.com/folke/snacks.nvim/discussions/732#discussioncomment-11942167

local gitsigns = require("gitsigns")

---@type snacks.picker.Config
return {
  actions = {
    open_file = function(picker)
      local pickedCommit = picker:current().commit
      picker:close()
      gitsigns.show(pickedCommit)
    end,
    diffview = function(picker)
      local pickedCommit = picker:current().commit
      picker:close()
      vim.cmd.diffoff({ bang = true })
      gitsigns.diffthis(pickedCommit .. '^')
    end,
  },
  win = {
    input = {
      keys = {
        ["<CR>"] = {
          "open_file",
          desc = "Open File",
          mode = { "n", "i" },
        },
        ["<c-d>"] = {
          "diffview",
          desc = "Diffview",
          mode = { "n", "i" },
        },
      },
    },
  },
}
