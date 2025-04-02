local ls = require("user.plugins.luasnip.luasnip_nodes")

local M = {}

M.ternary_c = ls.s("?:", ls.fmt([[
    ({}) ? {} : {};
  ]],
  {
    ls.i(1, "condition"),
    ls.i(2, "then"),
    ls.i(3, "else")
  })
)

M.printf = function(functionName)
  return ls.s("printf", ls.fmt([[
      {functionName}("{string}{newlineChoice}"{arguments});
    ]],
    {
      functionName = ls.t(functionName),
      string = ls.i(1),
      newlineChoice = ls.c(2, { ls.t("\\n"), ls.t("") }),
      arguments = ls.d(3, function(args)
        local nodes = {}
        local string = table.concat(args[1]):gsub("%%%%", "")
        local argCount = 0
        local keys = {}
        for match in string:gmatch("%%[^%% ]-([a-zA-Z][a-zA-Z]?)") do
          argCount = argCount + 1
          table.insert(keys, match)
        end
        if argCount > 0 then
          table.insert(nodes, ls.t(", "))
        end
        for j, key in ipairs(keys) do
          table.insert(nodes, ls.i(j, key))
          if j < argCount then
            table.insert(nodes, ls.t(", "))
          end
        end
        return ls.sn(1, nodes)
      end, 1),
    })
  )
end

M.while_c = ls.s("while", ls.fmt([[
    while ({}) {{
      {}
    }}
  ]],
  {
    ls.i(1, "condition"),
    ls.i(2),
  })
)

M.if_c = ls.s("if", ls.fmt([[
    if ({}) {{
      {}
    }}
  ]],
  {
    ls.i(1, "condition"),
    ls.i(2),
  })
)

M.if_c = ls.s("if", ls.fmt([[
    if ({}) {}
  ]],
  {
    ls.i(1, "condition"),
    ls.c(2, {
      ls.sn(nil, ls.fmt([[
      {{
        {}
      }}]],
        ls.i(1)
      )),
      ls.i(nil),
    }),
  })
)

return M
