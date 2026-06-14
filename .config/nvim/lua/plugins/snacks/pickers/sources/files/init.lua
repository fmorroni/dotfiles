---@type snacks.picker.Config
return {
  win = {
    input = {
      keys = {
        ["<a-g>"] = { "switch_grep", mode = { "i", "n" } },
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.files.actions"),
}
