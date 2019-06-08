--[[FATFILE
1
unknown
This program will handle controlling of a turtle, remotely.
]]


local prf = "Modules."
local remote = require(prf .. "Remote.Modem")
local draw = require(prf .. "CustomPaint")
local btn = require(prf .. "Pages.Button")
local obj = require(prf .. "Pages.Objects")
local pg = require(prf .. "Pages.Page")
local mx, my = term.getSize()
local iSelected = 1
local above = {"Empty"}
local front = {"Empty"}
local below = {"Empty"}
local wInvs = {
  tInv = {"Empty"},
  slot = {"1"},
  count = {"0"},
  wrpUp = {a = {"WRAP UP"}, b = {"Wrap up"}},
  wrp = {a = {"WRAP FT"}, b = {"Wrap"}},
  wrpDn = {a = {"WRAP DN"}, b = {"Wrap down"}}
}

local pages = {
  pg.new(),
  pg.new()
}
local buttonIDs = {}


local function initializePages()
  local main = pages[1]
  local peri = pages[2]
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
    "GO UP",
    "Go up",
    1
  )
  Mbtns["Go down"] = btn.new(
    1, 3,
    5, 4,
    colors.red,
    colors.white,
    colors.black,
    "GO DN",
    "Go down",
    1
  )
  Mbtns["Go forward"] = btn.new(
    10, 1,
    17, 2,
    colors.green,
    colors.white,
    colors.black,
    "GO FWD",
    "Go forward",
    1
  )
  Mbtns["Go back"] = btn.new(
    10, 3,
    17, 4,
    colors.red,
    colors.white,
    colors.black,
    "GO BWD",
    "Go back",
    1
  )
  Mbtns["Turn left"] = btn.new(
    7, 1,
    9, 4,
    colors.gray,
    colors.white,
    colors.black,
    "<--",
    "Turn left",
    1
  )
  Mbtns["Turn right"] = btn.new(
    18, 1,
    20, 4,
    colors.gray,
    colors.white,
    colors.black,
    "-->",
    "Turn right",
    1
  )
  Mbtns["Menu"] = btn.new(
    22, 1,
    mx, 4,
    colors.orange,
    colors.black,
    colors.yellow,
    "MENU",
    "Menu",
    2
  )
  Mbtns["Dig up"] = btn.new(
    1, 6,
    6, 7,
    colors.green,
    colors.white,
    colors.black,
    "DIG UP",
    "Dig up",
    1
  )
  Mbtns["Dig down"] = btn.new(
    1, 8,
    6, 9,
    colors.red,
    colors.white,
    colors.black,
    "DIG DN",
    "Dig down",
    1
  )
  Mbtns["Dig"] = btn.new(
    8, 6,
    12, 9,
    colors.gray,
    colors.white,
    colors.black,
    "DIG",
    "Dig",
    1
  )
  Mbtns["Use"] = btn.new(
    15, 6,
    19, 9,
    colors.gray,
    colors.white,
    colors.black,
    "USE",
    "Use",
    1
  )
  Mbtns["Use up"] = btn.new(
    21, 6,
    mx, 7,
    colors.green,
    colors.white,
    colors.black,
    "USE UP",
    "Use up",
    1
  )
  Mbtns["Use down"] = btn.new(
    21, 8,
    mx, 9,
    colors.red,
    colors.white,
    colors.black,
    "USE DN",
    "Use down",
    1
  )

  -----------------------------------------End of main page
  local div2C = colors.lightGray
  local Pbtns = {}

  peri:addObject(obj.new(
    1, my - 6,
    mx, my - 6,
    div2C
  ))
  peri:addObject(obj.new(
    8, 1,
    8, 6,
    div2C
  ))
  peri:addObject(obj.new(
    1, 7,
    8, 7,
    div2C
  ))
  peri:addObject(obj.new(
    4, 8,
    4, my - 7,
    div2C
  ))
  peri:addObject(obj.new(
    8, 8,
    8, my - 7,
    div2C
  ))
  peri:addObject(obj.new(
    mx - 5, 1,
    mx - 5, 4,
    div2C
  ))
  peri:addObject(obj.new(
    mx - 5, 5,
    mx, 5,
    div2C
  ))
  peri:addObject(obj.new(
    9, 10,
    mx, 10,
    div2C
  ))
  peri:addObject(obj.new(
    11, 11,
    11, 13,
    div2C
  ))
  peri:addObject(obj.new(
    mx - 2, 11,
    mx - 2, 13,
    div2C
  ))
  peri:addObject(obj.new(
    14, 11,
    14, 11,
    colors.black,
    colors.white,
    "Slot :"
  ))
  peri:addObject(obj.new(
    14, 12,
    14, 12,
    colors.black,
    colors.white,
    "Count:"
  ))
  peri:addObject(obj.new(
    12, 13,
    12, 13,
    colors.black,
    colors.white,
    wInvs.tInv
  ))
  peri:addObject(obj.new(
    19, 11,
    19, 11,
    colors.black,
    colors.white,
    wInvs.slot
  ))
  peri:addObject(obj.new(
    19, 12,
    19, 12,
    colors.black,
    colors.white,
    wInvs.count
  ))



  peri:addButton(btn.new(
    1, 1,
    7, 2,
    colors.green,
    colors.white,
    colors.black,
    wInvs.wrpUp.a,
    wInvs.wrpUp.b,
    1
  ))
  peri:addButton(btn.new(
    1, 3,
    7, 4,
    colors.gray,
    colors.white,
    colors.black,
    wInvs.wrp.a,
    wInvs.wrp.b,
    1
  ))
  peri:addButton(btn.new(
    1, 5,
    7, 6,
    colors.red,
    colors.white,
    colors.black,
    wInvs.wrpDn.a,
    wInvs.wrpDn.b,
    1
  ))
  peri:addButton(btn.new(
    mx - 4, 1,
    mx, 4,
    colors.orange,
    colors.black,
    colors.yellow,
    "CTRL",
    "Menu",
    2
  ))
  peri:addButton(btn.new(
    1, 8,
    3, 9,
    colors.green,
    colors.white,
    colors.black,
    "D U",
    "Drop up",
    1
  ))
  peri:addButton(btn.new(
    1, 10,
    3, 11,
    colors.gray,
    colors.white,
    colors.black,
    "D F",
    "Drop",
    1
  ))
  peri:addButton(btn.new(
    1, 12,
    3, 13,
    colors.red,
    colors.white,
    colors.black,
    "D D",
    "Drop down",
    1
  ))
  peri:addButton(btn.new(
    5, 8,
    7, 9,
    colors.green,
    colors.white,
    colors.black,
    "S U",
    "Suck up",
    1
  ))
  peri:addButton(btn.new(
    5, 10,
    7, 11,
    colors.gray,
    colors.white,
    colors.black,
    "S F",
    "Suck",
    1
  ))
  peri:addButton(btn.new(
    5, 12,
    7, 13,
    colors.red,
    colors.white,
    colors.black,
    "S D",
    "Suck down",
    1
  ))
  peri:addButton(btn.new(
    9, 11,
    10, 13,
    colors.gray,
    colors.white,
    colors.black,
    "<-",
    "Select -",
    1
  ))
  peri:addButton(btn.new(
    mx-1, 11,
    mx, 13,
    colors.gray,
    colors.white,
    colors.black,
    "->",
    "Select +",
    1
  ))



  for k, v in pairs(Mbtns) do
    main:addButton(v)
    buttonIDs[v.ID] = v.name
  end
end


local function redraw(a, b, c, d)
  pages[iSelected]:draw()
end

local function swap(a, b)
  local c = a
  a = b
  b = c
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
  local function wPrintError(stf)
    stsWin.setCursorPos(1, stsy)
    stsWin.scroll(1)
    local c = stsWin.getTextColor()
    stsWin.setTextColor(colors.red)
    stsWin.write(stf)
    stsWin.setTextColor(c)
  end

  wPrint("System Ready.")
  while true do
    local ev = {os.pullEvent()}
    local event = ev[1]
    if event == "modem_message" then
      local msg = ev[5]
      if msg[1] % 7 == 0 then
        -- (number divisible by 7) type val
        local tp = msg[2]
        local val = msg[3]
        local err = msg[4]
        if tp == "bAbove" then
          above[1] = val
        elseif tp == "bFront" then
          front[1] = val
        elseif tp == "bBelow" then
          below[1] = val
        elseif tp == "Turtle-Response" then
          os.cancelTimer(haltTmr or 0)
          haltTmr = 0
          wPrint("Done.")
          if val == "wwrap" then
            wPrint("Turtle has wrapped inv.")
            wInvs.wrpUp.a[1] = "UN WRAP"
            wInvs.wrp.a[1] = "UN WRAP"
            wInvs.wrpDn.a[1] = "UN WRAP"

            wInvs.wrpUp.b[1] = "Unwrap"
            wInvs.wrp.b[1] = "Unwrap"
            wInvs.wrpDn.b[1] = "Unwrap"
          elseif val == "uwrap" then
            wPrint("Turtle has unwrapped inv.")
            wInvs.wrpUp.a[1] = "WRAP UP"
            wInvs.wrp.a[1] = "WRAP FT"
            wInvs.wrpDn.a[1] = "WRAP DN"

            wInvs.wrpUp.b[1] = "Wrap up"
            wInvs.wrp.b[1] = "Wrap"
            wInvs.wrpDn.b[1] = "Wrap down"
          elseif val == "Inventory" then
            local c = err['c']
            local i = err['i']
            local s = err['s']
            if not c or not i or not s then
              wPrintError("Recieved corrupt message.")
            else
              wInvs.tInv[1] = i .. string.rep(' ', 12 - #i)
              wInvs.count[1] = c .. string.rep(' ', 2 - #tostring(c))
              wInvs.slot[1] = s .. string.rep(' ', 2 - #tostring(s))
            end
          end
          status = true
          os.cancelTimer(tmr or 0)
          tmr = os.startTimer(5)
          elseif val == "error" then
            wPrintError(err)
          end
          pages[iSelected]:enableAllButtons()
        elseif tp == "Turtle-Inventory" then

      end
    elseif event == "mouse_click" then
      local press = ev[2]
      local x = ev[3]
      local y = ev[4]
      local hit = pages[iSelected]:hit(x, y)
      if hit then
        local btn = pages[iSelected]:getButton(hit)
        if btn then
          if btn.t == 1 then
            local nm = type(btn.name) == "string" and btn.name
                      or type(btn.name) == "table" and btn.name[1]
            local chksum = math.random(1, 539)  * 7
            wPrint("Sending \"" .. nm .. "\"")
            remote.send({chksum, "Turtle-Request", nm})
            pages[iSelected]:disableAllButtons()
            haltTmr = os.startTimer(2)
          elseif btn.t == 2 then
            if btn.name == "Menu" then
              iSelected = iSelected + 1
              if iSelected > #pages then
                iSelected = 1
              end
              for y = 1, 13 do
                term.setCursorPos(1, y)
                io.write(string.rep(' ', mx))
              end
              wPrint("Swapping pages.")
              pages[iSelected]:draw()
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
        pages[iSelected]:enableAllButtons()
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
