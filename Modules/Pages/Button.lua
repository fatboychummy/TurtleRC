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
  term.setBackgroundColor(self.enabled and self.BGColor or self.disabledBGColor)
  term.setTextColor(self.FGColor)
  io.write(type(self.content) == "string" and self.content
          or type(self.content) == "table" and table.concat(self.content, ' ')
          or "")
  term.setBackgroundColor(obg)
  term.setTextColor(ofg)
end


function funcs.new(x1, y1, x2, y2, color, color2, color3, text, name, btnType)
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
    ID = lastID,
    name = name or "Button_" .. tostring(lastID),
    t = btnType or 1
  }
  lastID = lastID + 1
  setmetatable(tb, meta)
  return tb
end

return funcs
