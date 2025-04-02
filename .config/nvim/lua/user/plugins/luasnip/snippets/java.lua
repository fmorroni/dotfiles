local ls = require("user.plugins.luasnip.luasnip_nodes")

local sharedSnips = require("user.plugins.luasnip.shared_snips")

local forStatement = ls.s("for", ls.fmt([[
    for ({}) {{
      {}
    }}
  ]],
  {
    ls.c(1, {
      ls.sn(nil, ls.fmt("{} {} = {}; {}; {}", {
        ls.i(1, "int"),
        ls.i(2, "i"),
        ls.i(3, "0"),
        ls.c(4, {
          ls.fmt("{} < {}", { ls.rep(ls.ai[1][1][2]), ls.i(1, "max") }),
          ls.i(nil, "condition"),
        }),
        ls.d(5, function(args)
          return ls.sn(1, ls.i(1, "++" .. args[1][1]))
        end, 2),
      })),
      ls.sn(nil, ls.fmt("{} {} : {}", {
        ls.i(1, "type"),
        ls.i(2, "var"),
        ls.i(3, "iterable"),
      })),
    }),
    ls.i(2),
  })
)

local println = ls.s("print", ls.fmt([[
    System.out.println({});
  ]],
  {
    ls.i(1),
  })
)

local pkg = ls.s("package", ls.fmt([[
    package {};
  ]],
  {
    ls.f(function()
      return string.gsub(vim.fn.expand("%:.:h"), "/", ".")
    end),
  })
)

local visibilityNode = function(nodePos)
  return ls.c(nodePos, { ls.t("public "), ls.t("private "), ls.t("protected "), ls.t("") })
end
local getFileName = function()
  print("Getting file name")
  return vim.fn.expand("%:t:r")
end
local fileNameNode = function(nodePos)
  return ls.d(nodePos, function() return ls.sn(1, ls.i(1, getFileName())) end)
end

local objectSnip = function(objType)
  return ls.s(objType, ls.fmt([[
      {visibility}{abstract}{objType} {name} {inheritance}{}{{
        {body}
      }}
    ]],
    {
      visibility = visibilityNode(1),
      abstract = ls.c(2, { ls.t(""), ls.t("abstract ") }),
      objType = ls.t(objType),
      name = fileNameNode(3),
      inheritance = ls.i(4),
      ls.f(function(args) return (args[1][1] ~= "") and " " or "" end, 4),
      body = ls.i(5),
    })
  )
end

local class = objectSnip("class")
local interface = objectSnip("interface")
local enum = objectSnip("enum")

local methodSnip = function(trigger, nodes)
  return ls.s(trigger, ls.fmt([[
      {visibility}{abstract}{type}{name}({params}) {{
        {body}
      }}
    ]],
    nodes
  ))
end

local constructor = methodSnip("constructor", {
  visibility = visibilityNode(1),
  abstract = ls.t(""),
  type = ls.t(""),
  name = fileNameNode(2),
  params = ls.i(3),
  body = ls.i(4),
})

local method = methodSnip("method", {
  visibility = visibilityNode(1),
  abstract = ls.c(2, { ls.t(""), ls.t("abstract ") }),
  type = ls.sn(3, { ls.i(1, "void"), ls.t(" ") }),
  name = ls.i(4, "method"),
  params = ls.i(5),
  body = ls.i(6),
})

return {
  forStatement,
  println,
  sharedSnips.printf("System.out.printf"),
  sharedSnips.if_c,
  sharedSnips.ternary_c,
  class,
  pkg,
  interface,
  enum,
  constructor,
  method,
}
