---@type snacks.picker.Config
return {
  win = {
    input = {
      keys = {
        ["<M-g>"] = { "switch_files", mode = { "i", "n" } },
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.grep.actions"),
}
