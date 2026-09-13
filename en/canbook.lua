-- canbook.lua - the one part of the design that TeX macros cannot do cleanly.
--
-- \code{...} typesets code exactly as it is written. \detokenize gets almost all the way, but
-- leaves two artefacts: it doubles every #, so that #include would print as ##include, and it
-- puts a space after every control word, so that "\n" would become "\n ". Both are undone here,
-- and a line break is allowed after :: and after a comma with no space after it, so that a name
-- like driver::can::ByteTransport can break instead of running into the margin.

local catcode_other = -2

function canbook_code(s)
  s = s:gsub("#+", "#")
  s = s:gsub("(\\%a+) ", "%1")
  -- \%, \{ and \} are how a percent sign or an unbalanced brace has to be written inside a TeX
  -- argument, \# how a # has to be written in a heading, and \\ a lone backslash.
  s = s:gsub("\\([%%{}#\\])", "%1")
  local start = 1
  while true do
    local i, j = s:find("::", start, true)
    local k = s:find(",[^ ]", start)
    if k and (not i or k < i) then i, j = k, k end
    if not i then break end
    tex.sprint(catcode_other, s:sub(start, j))
    tex.sprint("\\penalty100 ")
    start = j + 1
  end
  tex.sprint(catcode_other, s:sub(start))
end
