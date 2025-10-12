vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP mappings",
  callback = function(event)
    ---@param mode string|string[]
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts vim.keymap.set.Opts?
    local bufmap = function(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = event.buf
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local builtin = require("telescope.builtin") -- Now loaded only when needed

    bufmap("n", "K", vim.lsp.buf.hover, { desc = "Display documentation of the symbol under the cursor" })
    -- bufmap('n', 'gd', vim.lsp.buf.definition, { desc = 'Jump to the definition' })
    bufmap("n", "gd", function() builtin.lsp_definitions({ reuse_win = true }) end, { desc = "Jump to the definition" })
    bufmap("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to declaration" })
    bufmap(
      "n",
      "gi",
      vim.lsp.buf.implementation,
      { desc = "Lists all the implementations for the symbol under the cursor" }
    )
    -- bufmap('n', 'go', vim.lsp.buf.type_definition, { desc = 'Jumps to the definition of the type symbol' })
    bufmap("n", "go", builtin.lsp_type_definitions, { desc = "Jumps to the definition of the type symbol" })
    -- bufmap('n', 'gr', vim.lsp.buf.references, { desc = 'Lists all the references' })
    bufmap("n", "gr", builtin.lsp_references, { desc = "Lists all the references" })
    bufmap("n", "gs", vim.lsp.buf.signature_help, { desc = "Displays a function's signature information" })

    bufmap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Renames all references to the symbol under the cursor" })
    -- In formatting.lua, otherwise it will only be available when a language server attaches.
    -- bufmap('n', '<leader>lf', conform.format, { desc = 'Format current file' })
    bufmap(
      "n",
      "<leader>la",
      vim.lsp.buf.code_action,
      { desc = "Selects a code action available at the current cursor position" }
    )

    bufmap(
      "n",
      "<leader>lj",
      function() vim.diagnostic.jump({ count = 1, float = true }) end,
      { desc = "Jump to next diagnostic" }
    )
    bufmap(
      "n",
      "<leader>lk",
      function() vim.diagnostic.jump({ count = -1, float = true }) end,
      { desc = "Jump to prev diagnostic" }
    )
    bufmap(
      "n",
      "<leader>lej",
      function() vim.diagnostic.jump({ count = 1, float = true, severity = "ERROR" }) end,
      { desc = "Jump to next error" }
    )
    bufmap(
      "n",
      "<leader>lek",
      function() vim.diagnostic.jump({ count = -1, float = true, severity = "ERROR" }) end,
      { desc = "Jump to prev error" }
    )
    bufmap(
      "n",
      "<leader>lwj",
      function() vim.diagnostic.jump({ count = 1, float = true, severity = "WARN" }) end,
      { desc = "Jump to next warning" }
    )
    bufmap(
      "n",
      "<leader>lwk",
      function() vim.diagnostic.jump({ count = -1, float = true, severity = "WARN" }) end,
      { desc = "Jump to prev warning" }
    )
    bufmap("n", "gl", vim.diagnostic.open_float, { desc = "Open floating diagnostics window" })

    pcall(vim.keymap.del, "n", "gri")
    pcall(vim.keymap.del, "n", "grr")
    pcall(vim.keymap.del, "n", "grt")
    pcall(vim.keymap.del, "n", "gra")
    pcall(vim.keymap.del, "n", "grn")
  end,
})
