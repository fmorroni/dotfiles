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
      keys = {
        -- Disable --
        ["<Esc>"] = false,
        ["<c-b>"] = false,
        ["<c-f>"] = false,
        ["<a-i>"] = false,
        -------------
        ["<a-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<a-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<a-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
        ["<a-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
        ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
        ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
        ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
        ["<C-p>"] = { "history_back", mode = { "i", "n" } },
        ["<a-P>"] = { "toggle_large_preview", mode = { "i", "n" } },
      },
    },
  },
  sources = {
    explorer = require("plugins.snacks.pickers.sources.explorer"),
    files = require("plugins.snacks.pickers.sources.files"),
    git_grep_hunks = require("plugins.snacks.pickers.sources.git_grep_hunks"),
    grep = require("plugins.snacks.pickers.sources.grep"),
  },
}
