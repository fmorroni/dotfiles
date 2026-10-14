local ls = require("plugins.luasnip.luasnip_nodes")

local M = {}

M[1] = ls.s(
  "import",
  ls.fmt(
    [[
      const {name} = @import("{module}"){extra};
    ]],
    {
      name = ls.i(1),
      module = ls.i(2, "module"),
      extra = ls.i(3),
    }
  )
)

---@param objType "struct" | "union" | "error set"
local objectSnip = function(objType)
  return ls.s(
    objType,
    ls.fmt(
      [[
        const {name} = {objType} {{
          {body}
        }};
      ]],
      {
        objType = ls.t(objType),
        name = ls.i(1),
        body = ls.i(2),
      }
    )
  )
end

M[2] = objectSnip("struct")
M[3] = objectSnip("union")
M[4] = objectSnip("error set")

M[5] = ls.s(
  "generic",
  ls.fmt(
    [[
      fn {name}(comptime {type}: type{extraArgs}) type {{
        return struct {{
          const Self = @This();

          {body}
        }};
      }}
    ]],
    {
      name = ls.i(1),
      type = ls.i(2, "T"),
      extraArgs = ls.i(3),
      body = ls.i(4),
    }
  )
)

M[6] = ls.s(
  "while",
  ls.fmt(
    [[
      while ({condition}) {choice}{{
          {body}
      }}
    ]],
    {
      condition = ls.i(1, "condition"),
      choice = ls.c(2, {
        ls.t(""),
        ls.fmt(": ({}) ", { ls.i(1, "update-expr") }),
        ls.fmt("|{}| ", { ls.i(1, "capture") }),
        ls.fmt("|{}| : ({}) ", { ls.i(1, "capture"), ls.i(1, "update-expr") }),
      }),
      body = ls.i(3),
    }
  )
)

return M
