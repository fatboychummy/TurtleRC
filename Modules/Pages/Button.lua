local funcs = {}
local meta = {}
local met = {}
local lastID = 1
meta.__index = met




local draw = require("Modules.CustomPaint")

function met:hit(x, y)
  return self.enabled
          and x <= self.x2 and x >= self.x1 and y <= self.y2 and y >= self.y1
end

function met:draw()
  draw.drawBox(self.x1, self.y1, self.x2, self.y2, ' ', self.enabled
                and self.BGColor or self.disabledBGColor)
  term.setCursorPos((self.x2 - math.floor(self.x2 - self.x1) / 2)
                    - self.content:len() / 2 + 1,
                    self.y2 - math.floor(self.y2 - self.y1) / 2)
  local obg = term.getBackgroundColor()
  local ofg = term.getTextColor()
  term.setBackgroundColor(self.enabled and self.BGColor or self.disabledBGColor)
  term.setTextColor(self.FGColor)
  io.write(self.content)
  term.setBackgroundColor(obg)
  term.setTextColor(ofg)
end


function funcs.new(x1, y1, x2, y2, color, color2, color3, text)
  local tb = {
    x1 = x1 or 0,
    x2 = x2 or 0,
    y1 = y1 or 0,
    y2 = y2 or 0,
    enabled = true,
    BGColor = color or colors.black,
    FGColor = color2 or colors.white,
    disabledBGColor = color3 or colors.black,
    content = text or "",
    ID = lastID
  }
  lastID = lastID + 1
  setmetatable(tb, meta)
  return tb
end

return funcs
