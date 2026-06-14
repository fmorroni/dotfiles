---@type snacks.picker.Config
return {
  win = {
    input = {
      keys = {
        ["<a-g>"] = { "switch_files", mode = { "i", "n" } },
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.grep.actions"),
}
