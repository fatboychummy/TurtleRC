--[[FATFILE
1
unknown

]]


local funcs = {}

function funcs.drawBox(x1, y1, x2, y2, fill, c)
  x1 = math.floor(x1)
  x2 = math.floor(x2)
  y1 = math.floor(y1)
  y2 = math.floor(y2)
  local o = term.getBackgroundColor()
  c = c or o
  local line = string.rep(fill or ' ', x2 - x1 + 1) -- +1 for inclusive

  term.setBackgroundColor(c)
  for y = y1, y2 do
    term.setCursorPos(x1, y)
    io.write(line)
  end
  term.setBackgroundColor(o)
end

return funcs
