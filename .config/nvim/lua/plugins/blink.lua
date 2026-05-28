return {
  {
    "saghen/blink.cmp",

    opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },

        ["<a-k>"] = { "scroll_documentation_up", "fallback" },
        ["<a-j>"] = { "scroll_documentation_down", "fallback" },

        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      completion = {
        menu = {
          border = "single",
        },
        documentation = {
          window = {
            border = "single",
          },
        },
        -- NOTE: may not want this, use it for a while and see.
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
  },
}
