local luasnip = require("luasnip")
local ls = require("user.luasnip_config.luasnip_nodes")

local image = ls.s("img", ls.fmt([[
    ![{altText}]({path})
  ]],
  {
    altText = ls.i(1, 'alternative text'),
    path = ls.i(2, 'image path'),
  })
)

local imageFromClipboard = ls.s("pimg", ls.fmt([[
    ![{altText}]({path})
  ]],
  {
    altText = ls.i(1, 'alternative text'),
    path = ls.f(function(args)
      local dirName = 'images'
      vim.cmd("[ ! -d " .. dirName .. " ] && mkdir " .. dirName)
      local clipboardDir = '/home/franco/.cache/xfce4/clipman/'
      vim.cmd("!cp " .. clipboardDir .. "(ls -At | awk '/image/' | head -1) " .. dirName .. "/" .. args[1][1])
      return dirName .. "/" .. args[1][1]
    end, { 1 }),
  })
)

local function findInArray(array, element)
  for i, ele in ipairs(array) do
    if ele == element then
      return i
    end
  end
  return -1
end

local function tableConcat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local greekAndSupSubSnips = function()
  local supSubTrig = {
    "^0", "^1", "^2", "^3", "^4", "^5", "^6", "^7", "^8", "^9",
    "^a", "^e", "^h", "^i", "^j", "^k", "^l", "^m", "^n", "^o", "^p", "^r", "^s", "^t", "^u", "^v", "^x",
    "^+", "^-",
    "_0", "_1", "_2", "_3", "_4", "_5", "_6", "_7", "_8", "_9",
    "_a", "_e", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_r", "_s", "_t", "_u", "_v", "_x",
    "_+", "_-"
  }
  local supSub = {
    "⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹",
    "ᵃ", "ᵉ", "ʰ", "ⁱ", "ʲ", "ᵏ", "ˡ", "ᵐ", "ⁿ", "ᵒ", "ᵖ", "ʳ", "ˢ", "ᵗ", "ᵘ", "ᵛ", "ˣ",
    "⁺", "⁻",
    "₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉",
    "ₐ", "ₑ", "ₕ", "ᵢ", "ⱼ", "ₖ", "ₗ", "ₘ", "ₙ", "ₒ", "ₚ", "ᵣ", "ₛ", "ₜ", "ᵤ", "ᵥ", "ₓ",
    "₊", "₋"
  }
  local greekTrigs = { "a", "b", "g", "G", "d", "D", "eps", "zeta", "eta", "theta", "Theta", "iota",
    "kappa", "l", "mu", "nu", "xi", "Xi", "pi", "Pi", "rho", "sigma", "Sigma", "tau", "ups",
    "phi", "Phi", "chi", "psi", "Psi", "omega", "Omega", "alef" }
  local greekLetters = { "α", "β", "ɣ", "𝛤", "δ", "Δ", "ε", "ζ", "η", "θ", "Θ", "ι", "κ", "λ", "μ",
    "ν", "ξ", "Ξ", "π", "Π", "ρ", "σ", "Σ", "τ", "υ", "φ", "Φ", "χ", "ψ", "Ψ", "ω", "Ω", "ℵ" }

  local snips = {}
  for i = 1, #greekTrigs do
    local trig = greekTrigs[i]
    local l = greekLetters[i]
    snips[i] = ls.s({ trig = "\\" .. trig .. "([^_^%w])", regTrig = true, wordTrig = false }, {
      ls.f(function(_, snip)
        local extraChar = (snip.captures[1] == ".") and "" or snip.captures[1]
        if extraChar then
          return l .. extraChar
        else
          return snip.trigger
        end
      end)
    })
  end

  table.insert(snips, ls.s({ trig = "\\(%a*)([_^]%w)", regTrig = true, wordTrig = false }, {
    ls.f(function(_, snip)
      local lhs = greekLetters[findInArray(greekTrigs, snip.captures[1])]
      local rhs = supSub[findInArray(supSubTrig, snip.captures[2])]
      if lhs and rhs then
        return lhs .. rhs
      elseif rhs then
        return snip.captures[1] .. rhs
      else
        return snip.trigger
      end
    end)
  })
  )

  table.insert(snips, ls.s({ trig = "\\(%a*)([_^])([+-])(%w),(%w)", regTrig = true, wordTrig = false }, {
    ls.f(function(_, snip)
      local lhs = greekLetters[findInArray(greekTrigs, snip.captures[1])]
      local op = supSub[findInArray(supSubTrig, snip.captures[2] .. snip.captures[3])]
      local rhs1 = supSub[findInArray(supSubTrig, snip.captures[2] .. snip.captures[4])]
      local rhs2 = supSub[findInArray(supSubTrig, snip.captures[2] .. snip.captures[5])]
      if lhs and rhs1 and op and rhs2 then
        return lhs .. rhs1 .. op .. rhs2
      else
        return snip.trigger
      end
    end)
  })
  )

  return snips
end

local wordTrigFalse = function(trig)
  return { trig = trig, wordTrig = false }
end

local autosnips = {
  ls.s(wordTrigFalse("\\empty"), ls.t("∅")),
  ls.s(wordTrigFalse("\\then"), ls.t("⟹ ")),
  ls.s(wordTrigFalse("\\lthen"), ls.t("⟸ ")),
  ls.s(wordTrigFalse("\\iff"), ls.t("⇐⇒")),
  ls.s(wordTrigFalse("\\not"), ls.t("¬")),
  -- Satisfies
  ls.s(wordTrigFalse("\\TT"), ls.t("⊨")),
  ls.s(wordTrigFalse("\\nTT"), ls.t("⊭")),
  -- Proves
  ls.s(wordTrigFalse("\\T "), ls.t("⊢ ")),
  ls.s(wordTrigFalse("\\nT "), ls.t("⊬ ")),
  ls.s(wordTrigFalse("\\bel"), ls.t("∈")),
  ls.s(wordTrigFalse("\\nbel"), ls.t("∉")),
  ls.s(wordTrigFalse("\\E"), ls.t("∃")),
  ls.s(wordTrigFalse("\\nE"), ls.t("∄")),
  ls.s(wordTrigFalse("\\forall"), ls.t("∀")),
  -- Therefore
  ls.s(wordTrigFalse("\\tf"), ls.t("∴")),
  ls.s(wordTrigFalse("\\le"), ls.t("≤")),
  ls.s(wordTrigFalse("\\ge"), ls.t("≥")),
  ls.s(wordTrigFalse("\\ne"), ls.t("≠")),
  ls.s(wordTrigFalse("\\and"), ls.t("∧")),
  ls.s(wordTrigFalse("\\or"), ls.t("∨")),
  ls.s(wordTrigFalse("\\eq"), ls.t("≡")),
  -- Subset
  ls.s(wordTrigFalse("\\c"), ls.t("⊆")),
  -- Proper subset
  ls.s(wordTrigFalse("\\pc"), ls.t("⊊")),
  ls.s(wordTrigFalse("\\u"), ls.t("⋃")),
  ls.s(wordTrigFalse("\\n "), ls.t("⋂ ")),
  -- Wave arrow
  ls.s(wordTrigFalse("\\wa"), ls.t("⤳")),
  ls.s(wordTrigFalse("\\la"), ls.t("⟶ ")),
  ls.s(wordTrigFalse("\\F"), ls.t("𝐹")),
  ls.s(wordTrigFalse("\\Q"), ls.t("ℚ")),
  ls.s(wordTrigFalse("\\Z"), ls.t("ℤ")),
  ls.s(wordTrigFalse("\\N"), ls.t("ℕ")),
}
tableConcat(autosnips, greekAndSupSubSnips())

-- local function triggerExpand(trig)
--   for _, snip in ipairs(autosnips) do
--
--   end
-- end

-- -- See postfix-snipptet -- --
-- local mathBlock = ls.s({ trig = "$(.*)$", regTrig = true, wordTrig = false }, {
--   ls.f(function(_, snip)
--     local ret = ""
--     for _, trig in pairs(vim.fn.split(snip.captures[1], " ")) do
--       for _, ausnip in ipairs(autosnips) do
--         if string.match("\\" .. trig, ausnip.trigger) then
--           P({ "in math block", ausnip.trigger, ausnip.captures })
--           ret = ret .. "\\" .. trig .. " "
--           -- luasnip.snip_expand(ausnip, {
--           --   expand_params = { trigger = "\\" .. trig }
--           --   -- expand_params = { captures = { "a", "_i" } }
--           -- })
--           -- luasnip.expand_auto()
--           break
--         end
--       end
--     end
--     return ret
--   end)
-- })
-- table.insert(autosnips, mathBlock)

-- for i, snip in ipairs(autosnips) do
--   P({ i, snip.trigger })
-- end



return {
  image,
  imageFromClipboard,
}, autosnips
