local funcs = {}
local meta = {}
local met = {}
meta.__index = met

local draw = require("/TurtleRC/CustomPaint")

function met:draw()
  draw.drawBox(self.x1, self.y1, self.x2, self.y2, ' ', self.BGColor)
  term.setCursorPos(type(self.content) == "string"
                      and (self.x2 - math.floor(self.x2 - self.x1) / 2)
                      - self.content:len() / 2 + 1
                      or self.x1,
                    type(self.content) == "string"
                      and self.y2 - math.floor(self.y2 - self.y1) / 2
                      or self.y1
                    )
  local obg = term.getBackgroundColor()
  local ofg = term.getTextColor()
  term.setBackgroundColor(self.BGColor)
  term.setTextColor(self.FGColor)
  io.write(type(self.content) == "string" and self.content
          or type(self.content) == "table" and table.concat(self.content, ' ')
          or "")
  --if content is a table, it allows for changing what will be written here!
  term.setBackgroundColor(obg)
  term.setTextColor(ofg)
end

function funcs.new(x1, y1, x2, y2, color, color2, text)
  local tb = {
    x1 = x1 or 0,
    x2 = x2 or 0,
    y1 = y1 or 0,
    y2 = y2 or 0,
    BGColor = color or colors.black,
    FGColor = color2 or colors.white,
    content = text or "",
  }
  setmetatable(tb, meta)
  return tb
end

return funcs
