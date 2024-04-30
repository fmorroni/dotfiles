-- Generic markdown specific configs.
local map = require('user.utils.ftplugin-map').map
map("n", "<leader>v", "<CMD>PasteImg<CR>", { desc = 'Paste image from clipboard' })
map("n", "<leader>x", "<CMD>PeekOpen<CR>", { desc = 'PeekOpen' })

-- Config for markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  map("n", "gd", '', { desc = 'Go to linked note', callback = vim.lsp.buf.definition })
  map("v", "<leader>zn", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
    { desc = 'New note with selection as title' })
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  -- map("v", "<leader>znc",
  --   ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

  -- map('n', 'gr', "<Cmd>ZkBacklinks<CR>", vim.tbl_extend('force', opts, { desc = 'List backlinks' }))
  map('n', 'gr', "<CMD>Telescope lsp_references<CR>", { desc = 'List backlinks' })
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = 'List notes linked by current buffer' })
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = 'Preview linked note' })
  map("n", "gl", "", {
    desc = "Show line diagnostics",
    callback =
        function()
          local float = vim.diagnostic.config().float

          if float then
            local config = type(float) == "table" and float or {}
            config.scope = "line"

            vim.diagnostic.open_float(config)
          end
        end,
  })
  map('v', '<leader>zi', "<Cmd>'<,'>ZkInsertLinkAtSelection<CR>", { desc = 'Insert link at selection' })

  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", { desc = 'Show code actions for selection' })

  -- Set conceal level
  vim.api.nvim_cmd({ cmd = 'setlocal', args = { 'conceallevel=2' } }, {})
  -- Disable folding
  vim.api.nvim_cmd({ cmd = 'set', args = { 'nofoldenable' } }, {})
end
