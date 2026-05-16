---@type snacks.picker.Config
return {
  win = {
    input = {
      keys = {
        ["<M-g>"] = { "switch_grep", mode = { "i", "n" } },
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.files.actions"),
}
