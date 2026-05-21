return {
  input_and_list = {
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
    ["<a-p>"] = { "toggle_only_preview", mode = { "i", "n" } },
    ["<a-P>"] = { "toggle_preview", mode = { "i", "n" } },
    ["<c-l>"] = { "focus_preview", mode = { "i", "n" } },
  },
  preview = {
    -- Disable --
    ["<Esc>"] = false,
    -------------
    ["<a-p>"] = { "toggle_only_preview" },
    ["?"] = { "toggle_help_preview" },
    ["<c-h>"] = { "focus_input_normal_mode" },
    ["<c-l>"] = { "focus_input_normal_mode" },
    ["<a-m>"] = { "toggle_maximize" },
  },
}
