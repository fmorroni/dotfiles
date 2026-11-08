-- Creating a new source allows keeping a separate state which then works with `resume`

local seen = require("plugins.snacks.pickers.sources.git_diff_upstream.seen")

-- Diff against the current branch's upstream (e.g. origin/0.17.x). Falls back to
-- `origin` (origin/HEAD, the remote's default branch) when the branch has no upstream.
---@type snacks.picker.finder
local function finder(opts, ctx)
  ---@cast opts snacks.picker.git.diff.Config
  opts.base = require("util.git").upstream(ctx:git_root())
  return require("snacks.picker.source.git").diff(opts, ctx)
end

return vim.tbl_deep_extend("force", require("snacks.picker.config.sources").git_diff, {
  sort = { fields = { "file", "idx" } },
  finder = finder,
  group = true,
  title = "  Git Diff (upstream)",
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
