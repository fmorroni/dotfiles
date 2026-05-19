return {
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.cmd([[
				function OpenMarkdownPreview (url)
					execute "silent ! brave --new-window --incognito " . a:url
				endfunction
				let g:mkdp_browserfunc = 'OpenMarkdownPreview'

        do FileType
			]])
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
        keys = function()
          return {
            { "<leader>v", "<CMD>PasteImg<CR>", ft = "markdown", desc = "Paste image from clipboard" },
          }
        end,
      },
    },
  },
}
