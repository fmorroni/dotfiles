-- Creating a new source allows keeping a separate state which then works with `resume`

return vim.tbl_deep_extend("force", require("snacks.picker.config.sources").git_diff, {
  sort = { fields = { "file", "idx" } },
  base = "HEAD~1",
  group = true,
  title = "  Git Diff (HEAD~1)",
})
