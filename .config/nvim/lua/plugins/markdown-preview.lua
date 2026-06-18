return {
  {
    "fmorroni/markdown-preview.nvim",
    build = "cd app && deno task build",
    name = "md-preview",
    ft = { "markdown" },
    ---@type MarkdownPreview.Config
    opts = {
      browser = { "brave", "--incognito", "--new-window" },
      port = 9999,
    },
    keys = function()
      local mdp = require("md-preview")
      return {
        { "<leader>cp", mdp.open, desc = "Open markdown preview" },
      }
    end,
    dependencies = {
      {
        "dfendr/clipboard-image.nvim",
        opts = {
          -- Default configuration for all filetype
          default = {
            img_dir = { "%:p:h", ".images" },
            img_dir_txt = ".images",
            img_name = function() return os.date("%Y-%m-%d-%H-%M-%S") end, -- Example result: "2021-04-13-10-04-18"
            affix = "<\n  %s\n>", -- Multi lines affix
          },
        },
        keys = { "<leader>v", "<CMD>PasteImg<CR>", ft = "markdown", desc = "Paste image from clipboard" },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
}
