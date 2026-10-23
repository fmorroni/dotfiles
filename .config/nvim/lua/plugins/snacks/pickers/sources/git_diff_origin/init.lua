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
    toggle_seen_up = { action = seen.toggle_seen, dir = -1 },
    toggle_seen_stay = { action = seen.toggle_seen, dir = 0 },
    clear_seen = seen.clear_seen,
  },
  win = {
    input = {
      keys = {
        ["<c-j>"] = { "toggle_seen", mode = { "n", "i" }, desc = "Toggle seen (down)" },
        ["<c-k>"] = { "toggle_seen_up", mode = { "n", "i" }, desc = "Toggle seen (up)" },
        ["<a-S>"] = { "clear_seen", mode = { "n", "i" }, desc = "Clear all seen" },
      },
    },
    list = {
      keys = {
        ["<c-j>"] = { "toggle_seen", desc = "Toggle seen (down)" },
        ["<c-k>"] = { "toggle_seen_up", desc = "Toggle seen (up)" },
        ["<a-S>"] = { "clear_seen", desc = "Clear all seen" },
      },
    },
    preview = {
      keys = {
        ["<tab>"] = { "toggle_seen_stay", desc = "Toggle seen" },
      },
    },
  },
})
