return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          -- Go to closest matching textobject.
          lookahead = true,
          keymaps = {
            -- See available textobjects with `:TSEditQuery textobjects`
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- You can also use captures from other query groups like `:TSEditQuery locals`
            ["as"] = { "@scope", query_group = "locals", desc = "Select language scope" }
          },
          -- selection_modes = {
          --   ['@parameter.outer'] = 'v', -- charwise
          --   ['@function.outer'] = 'V',  -- linewise
          --   ['@class.outer'] = '<c-v>', -- blockwise
          -- },
          include_surrounding_whitespace = true,
        },
        move = {
          -- poiu = function()
          --   function test (a, b, c) end
          -- end,
          -- asdf = a + b + c + d,
          -- qwer = function(a, b, c)

          -- end,
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            -- ["]o"] = "@loop.*",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            ["]l"] = "@loop.outer",
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[l"] = "@loop.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[L"] = "@loop.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            -- @operand is a textobject I was trying to create in order to swap operands in a binary operation
            -- but it doesn't seem to be posible according to a github issue.
            -- ["<a-l>"] = { query = { "@parameter.inner", "@operand" } },
            ["<a-l>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<a-h>"] = "@parameter.inner",
          },
        },
      }
    })
  end
}
