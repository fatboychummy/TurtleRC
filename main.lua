--[[FATFILE
1
unknown
This program will handle controlling of a turtle, remotely.
]]


local remote = require("Remote.Modem")
local draw = require("CustomPaint")
local btn = require("Pages.Button")
local obj = require("Pages.Objects")
local pg = require("Pages.Page")
local mx, my = term.getSize()
local iSelected = 1
local above = {"Empty"}
local front = {"Empty"}
local below = {"Empty"}

local pages = {
  pg.new(),
  pg.new()
}
local buttonIDs = {}


local function initializePages()
  local main = pages[1]

  local divC = colors.lightGray

  main:addObject(obj.new(
    1, 5,
    mx, 5,
    divC
  ))
  main:addObject(obj.new(
    6, 1,
    6, 4,
    divC
  ))
  main:addObject(obj.new(
    15, 1,
    15, 4,
    divC
  ))
  main:addObject(obj.new(
    1, 10,
    mx, 10,
    divC
  ))
  main:addObject(obj.new(
    21, 1,
    21, 4,
    divC
  ))
  main:addObject(obj.new(
    1, my - 6,
    mx, my - 6,
    divC
  ))
  main:addObject(obj.new(
    7, 6,
    7, 9,
    divC
  ))
  main:addObject(obj.new(
    13, 6,
    14, 9,
    divC
  ))
  main:addObject(obj.new(
    20, 6,
    20, 9,
    divC
  ))
  main:addObject(obj.new(
    3, 11,
    3, 11,
    colors.black,
    colors.white,
    "Above:"
  ))
  main:addObject(obj.new(
    8, 11,
    8, 11,
    colors.black,
    colors.white,
    above
  ))
  main:addObject(obj.new(
    3, 12,
    3, 12,
    colors.black,
    colors.white,
    "Front:"
  ))
  main:addObject(obj.new(
    8, 12,
    8, 12,
    colors.black,
    colors.white,
    front
  ))
  main:addObject(obj.new(
    3, 13,
    3, 13,
    colors.black,
    colors.white,
    "Below:"
  ))
  main:addObject(obj.new(
    8, 13,
    8, 13,
    colors.black,
    colors.white,
    below
  ))

  local Mbtns = {}

  Mbtns["Go up"] = btn.new(
    1, 1,
    5, 2,
    colors.green,
    colors.white,
    colors.black,
    "GO UP"
  )
  Mbtns["Go down"] = btn.new(
    1, 3,
    5, 4,
    colors.red,
    colors.white,
    colors.black,
    "GO DN"
  )
  Mbtns["Go forward"] = btn.new(
    10, 1,
    17, 2,
    colors.green,
    colors.white,
    colors.black,
    "GO FWD"
  )
  Mbtns["Go back"] = btn.new(
    10, 3,
    17, 4,
    colors.red,
    colors.white,
    colors.black,
    "GO BWD"
  )
  Mbtns["Turn left"] = btn.new(
    7, 1,
    9, 4,
    colors.gray,
    colors.white,
    colors.black,
    "<--"
  )
  Mbtns["Turn right"] = btn.new(
    18, 1,
    20, 4,
    colors.gray,
    colors.white,
    colors.black,
    "-->"
  )
  Mbtns["Menu"] = btn.new(
    22, 1,
    mx, 4,
    colors.orange,
    colors.black,
    colors.yellow,
    "MENU"
  )
  Mbtns["Dig up"] = btn.new(
    1, 6,
    6, 7,
    colors.green,
    colors.white,
    colors.black,
    "DIG UP"
  )
  Mbtns["Dig down"] = btn.new(
    1, 8,
    6, 9,
    colors.red,
    colors.white,
    colors.black,
    "DIG DN"
  )
  Mbtns["Dig"] = btn.new(
    8, 6,
    12, 9,
    colors.gray,
    colors.white,
    colors.black,
    "DIG"
  )
  Mbtns["Use"] = btn.new(
    15, 6,
    19, 9,
    colors.gray,
    colors.white,
    colors.black,
    "USE"
  )
  Mbtns["Use up"] = btn.new(
    21, 6,
    mx, 7,
    colors.green,
    colors.white,
    colors.black,
    "USE UP"
  )
  Mbtns["Use down"] = btn.new(
    21, 8,
    mx, 9,
    colors.red,
    colors.white,
    colors.black,
    "USE DN"
  )

  for k, v in pairs(Mbtns) do
    main:addButton(v)
    buttonIDs[v.ID] = k
  end
end


local function redraw(a, b, c, d)
  pages[iSelected]:draw()
end

local function main()
  initializePages()
  remote.init()
  term.clear()
  local stsWin = window.create(term.current(), 1, my-5, mx, 6)
  local stsx, stsy = stsWin.getSize()
  local tmr = os.startTimer(5)
  local haltTmr
  local status = false
  local function wPrint(stf)
    stsWin.setCursorPos(1, stsy)
    stsWin.scroll(1)
    stsWin.write(stf)
  end

  wPrint("System Ready.")
  while true do
    local ev = {os.pullEvent()}
    local event = ev[1]
    if event == "modem_message" then
      local msg = ev[5]
      if tonumber(msg:match("^%d+")) % 7 == 0 then
        -- (number divisible by 7) type val
        local tp = msg:match("^%d+ (%S+)")
        local val = msg:match("^%d+ %S+ (.+)")
        if tp == "bAbove" then
          above[1] = val
        elseif tp == "bFront" then
          front[1] = val
        elseif tp == "bBelow" then
          below[1] = val
        elseif tp == "COMPLETE" then
          os.cancelTimer(haltTmr or 0)
          wPrint("Done.")
          pages[1]:enableAllButtons()
        end
        status = true
        os.cancelTimer(tmr or 0)
        tmr = os.startTimer(5)
      end
    elseif event == "mouse_click" then
      local press = ev[2]
      local x = ev[3]
      local y = ev[4]
      local hit = pages[iSelected]:hit(x, y)
      if hit then
        hit = buttonIDs[hit]
        if hit then
          local things = {
            "Go up",
            "Go down",
            "Go forward",
            "Go back",
            "Turn left",
            "Turn right",
            "Dig",
            "Dig down",
            "Dig up",
            "Use",
            "Use up",
            "Use down"
          }
          local flg = true
          for i = 1, #things do
            if hit == things[i] then
              wPrint("Sending \"" .. hit .. "\"")
              haltTmr = os.startTimer(2)
              pages[1]:disableAllButtons()
              if not remote.send(hit) then
                wPrint("Cannot send messages.")
                wPrint("Unknown error occurred!")
              end
              flg = false
              break
            end
          end
          if flg then
            if hit == "Menu" then
              wPrint("Swapping menus")
              iSelected = iSelected + 1
              if iSelected > #pages then
                iSelected = 1
              end
              wPrint(iSelected)
            end
          end
        end
      end
    elseif event == "timer" then
      if tmr == ev[2] then
        status = false
        --wPrint("Warning: Disconnected.")
        tmr = os.startTimer(5)
      elseif haltTmr == ev[2] then
        pages[1]:enableAllButtons()
        wPrint("Did not recieve response.")
      end
    end
    redraw()
  end
end


local ok, er = pcall(main)
if not ok then
  if remote then
    remote.send({t = "Error", c = er})
  end
  error(er, -1)
end
