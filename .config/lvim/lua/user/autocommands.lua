lvim.autocommands = {
  {
    "ColorScheme",
    {
      pattern = { "*" },
      callback = function()
        vim.cmd("hi link IlluminatedWord LspReferenceText")
        vim.cmd("hi link IlluminatedWordText LspReferenceText")
        vim.cmd("hi link IlluminatedWordRead LspReferenceRead")
        vim.cmd("hi link IlluminatedWordWrite LspReferenceWrite")
        vim.cmd("hi Visual guibg=#2d2971")
      end
    }
  },
  {
    "VimEnter",
    {
      callback = function()
        -- LSP
        lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<CMD>Telescope lsp_references<CR>", "Telescope references" }
        lvim.keys.normal_mode["gr"] = "<CMD>Telescope lsp_references<CR>"
      end
    }
  },
  {
    "FileType",
    {
      pattern = "TelescopeResults",
      command = "setlocal nofoldenable",
    }
  },
  {
    { "BufNewFile", "BufRead" },
    {
      pattern = "*.rasi",
      callback = function()
        vim.cmd("setf rasi")
        vim.cmd("set commentstring=//%s")
      end
    }
  }
}
