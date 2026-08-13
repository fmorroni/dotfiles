-- Creating a new source allows keeping a separate state which then works with `resume`

return vim.tbl_deep_extend("force", require("snacks.picker.config.sources").git_diff, {
  sort = { fields = { "file", "idx" } },
  base = "origin",
  group = true,
  title = "  Git Diff (base)",
})
