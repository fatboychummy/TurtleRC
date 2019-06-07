--[[FATFILE
1
unknown

]]

local modem = false
local m = false
local tChannel = 1

local funcs = {}

function funcs.send(...)
  if m then
    modem.transmit(tChannel, tChannel, ...)
    return true
  else
    return false
  end
end

function funcs.listen()
  local ev = {os.pullEvent("modem_message")}
  return ev[5]
end

function funcs.init()
  local modems = {peripheral.find("modem")}
  for i = 1, #modems do
    if modems[i].isWireless() then
      modem = modems[i]
      m = true
    end
  end
  if not m then
    error("No wireless modem!")
  end
  modem.open(1)
end

return funcs
