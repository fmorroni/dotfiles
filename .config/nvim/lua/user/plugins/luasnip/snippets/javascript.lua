local ls = require("user.plugins.luasnip.luasnip_nodes")

local sharedSnips = require("user.plugins.luasnip.shared_snips")

local function defExport(args)
  local default = string.match(args[1][1], "(%a*).?%a*$")
  return ls.sn(nil, ls.c(1, {
    ls.sn(nil, { ls.t("{ "), ls.i(1), ls.t(" }") }),
    ls.i(nil, default),
  }))
end

local import = ls.s("import", ls.fmt([[
    import {} from '{}'
  ]],
  {
    ls.d(2, defExport, 1),
    ls.i(1, "path"),
  })
)

local tryCatch = ls.s("try", ls.fmt([[
    try {{
      {}
    }} catch({}) {{
      {}
    }}
  ]],
  {
    ls.i(1),
    ls.i(2, 'err'),
    ls.i(3),
  })
)

local forStatement = ls.s("for", ls.fmt([[
    for ({}) {{
      {}
    }}
  ]],
  {
    ls.c(1, {
      ls.sn(nil, {
        ls.i(1), -- Needed to be able to switch to the other ls.sn().
        ls.t("const "),
        ls.c(2, {
          ls.sn(nil, { ls.i(1, "ele"), ls.t(" of "), ls.i(2, "iterable") }),
          ls.sn(nil, { ls.i(1, "key"), ls.t(" in "), ls.i(2, "obj") }),
        }),
      }),
      ls.sn(nil, ls.fmt("let {} = {}; {}; {}", {
        ls.i(1, "i"),
        ls.i(2, "0"),
        ls.c(3, {
          ls.fmt("{} < {}.length", { ls.rep(ls.ai[1][2][1]), ls.i(1, "array") }),
          ls.i(nil, "condition"),
        }),
        ls.d(4, function(args)
          return ls.sn(1, ls.i(1, "++" .. args[1][1]))
        end, 1),
      })),
      ls.i(nil, ""),
    }),
    ls.i(2),
  })
)

local printSnip = ls.s("print", ls.fmt([[
    console.log({})
  ]],
  {
    ls.i(1),
  })
)

local class = ls.s("class", ls.fmt([[
    class {name} {inheritance}{{
      constructor({args}) {{
        {props}{body}
      }}
    }}
  ]],
  {
    name = ls.i(1, "Name"),
    inheritance = ls.c(2, { ls.t(""), ls.sn(nil, { ls.t("extends "), ls.i(1, "Name") }) }),
    args = ls.i(3, "args"),
    props = ls.d(4, function(argsNode)
      local args = string.gmatch(argsNode[1][1], "([a-zA-Z0-9_]+)%s*,?%s*")

      local props = {}
      local i = 0
      for arg in args do
        i = i + 1
        table.insert(props, ls.sn(i, { ls.t("this."), ls.i(1, arg), ls.t({ " = " .. arg, "" }) }))
      end

      return ls.isn(1, props, "    $PARENT_INDENT")
    end, 3),
    body = ls.i(5, ""),
  })
)

return {
  import,
  sharedSnips.if_c,
  tryCatch,
  forStatement,
  sharedSnips.ternary_c,
  printSnip,
  class,
}
