---@type snacks.picker.Config
return {
  filter = { cwd = true },
  win = {
    input = {
      keys = {
        ["<a-c>"] = { "toggle_cwd", mode = { "i", "n" } }
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.buffers.actions"),
}
