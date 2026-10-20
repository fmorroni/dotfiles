-- Creating a new source allows keeping a separate state which then works with `resume`

local seen = require("plugins.snacks.pickers.sources.git_diff_origin.seen")

return vim.tbl_deep_extend("force", require("snacks.picker.config.sources").git_diff, {
  sort = { fields = { "file", "idx" } },
  base = "origin",
  group = true,
  title = "  Git Diff (origin)",
  format = seen.format,
  actions = {
    toggle_seen = seen.toggle_seen,
    clear_seen = seen.clear_seen,
  },
  win = {
    input = {
      keys = {
        ["<tab>"] = { "toggle_seen", mode = { "n", "i" }, desc = "Toggle seen" },
        ["<a-S>"] = { "clear_seen", mode = { "n", "i" }, desc = "Clear all seen" },
      },
    },
    list = {
      keys = {
        ["<tab>"] = { "toggle_seen", desc = "Toggle seen" },
        ["<a-S>"] = { "clear_seen", desc = "Clear all seen" },
      },
    },
  },
})
