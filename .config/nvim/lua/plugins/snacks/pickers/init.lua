---@type snacks.picker.Config
return {
  layout = {
    -- preset = "ivy",
  },
  actions = require("plugins.snacks.pickers.actions"),
  matcher = {
    -- Doesn't seem to be working.
    frecency = true,
  },
  win = {
    input = {
      keys = require("plugins.snacks.pickers.keymaps").input_and_list,
    },
    list = {
      keys = require("plugins.snacks.pickers.keymaps").input_and_list,
    },
    preview = {
      keys = require("plugins.snacks.pickers.keymaps").preview,
    },
  },
  sources = {
    buffers = require("plugins.snacks.pickers.sources.buffers"),
    explorer = require("plugins.snacks.pickers.sources.explorer"),
    files = require("plugins.snacks.pickers.sources.files"),
    git_grep_hunks = require("plugins.snacks.pickers.sources.git_grep_hunks"),
    grep = require("plugins.snacks.pickers.sources.grep"),
  },
}
