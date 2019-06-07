local funcs = {}
local meta = {}
local met = {}
meta.__index = met


function funcs.new(ID)
  local tb = {
    content = {},
    buttons = {}
  }
  setmetatable(tb, meta)
  return tb
end

function met:addButton(button)
  self.buttons[#self.buttons + 1] = button
end

function met:addObject(obj)
  self.content[#self.content + 1] = obj
end

function met:enableButton(btnID)
  for i = 1, #self.buttons do
    if self.buttons[i].ID == btnID then
      self.buttons[i].enabled = true
    end
  end
end

function met:disableButton(btnID)
  for i = 1, #self.buttons do
    if self.buttons[i].ID == btnID then
      self.buttons[i].enabled = false
    end
  end
end

function met:disableAllButtons()
  for i =1, #self.buttons do
    self.buttons[i].enabled = false
  end
end

function met:enableAllButtons()
  for i =1, #self.buttons do
    self.buttons[i].enabled = true
  end
end

function met:draw()
  for i = 1, #self.content do
    self.content[i]:draw()
  end
  for i = 1, #self.buttons do
    self.buttons[i]:draw()
  end
end

function met:hit(x, y)
  for i = 1, #self.buttons do
    if self.buttons[i]:hit(x, y) then
      return self.buttons[i].ID
    end
  end
  return false
end


return funcs
