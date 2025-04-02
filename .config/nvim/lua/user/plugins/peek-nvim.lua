return {
  {
    "fmorroni/peek.nvim",
    branch = "my-main",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    opts = {
      -- app = { 'brave', '--new-window' },
    },
    -- Has to be a function if I want to require("peek") because otherwise it requires before loading the package and fails.
    keys = function()
      return {
        { "<leader>v", "<CMD>PasteImg<CR>",  ft = "markdown", desc = 'Paste image from clipboard' },
        { "<leader>x", require("peek").open, ft = "markdown", desc = 'Open markdown previewer' },
      }
    end
    -- dependecies = {
    --   {
    --     'dfendr/clipboard-image.nvim',
    --     opts = {
    --       -- Default configuration for all filetype
    --       default = {
    --         img_dir = { "%:p:h", ".images" },
    --         img_dir_txt = ".images",
    --         img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
    --         affix = "<\n  %s\n>",                                          -- Multi lines affix
    --       },
    --     }
    --   },
    -- }
  }
}
