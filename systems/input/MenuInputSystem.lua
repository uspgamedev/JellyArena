local MenuInputSystem = class("MenuInputSystem", System)

function MenuInputSystem:update(dt)
  if (love.keyboard.isDown("down")) then
    nextMenuItem()
  elseif (love.keyboard.isDown("up")) then
    previousMenuItem()
  elseif (love.keyboard.isDown("return")) then
    selectMenuitem()
  end
  playSound("select")
end

function MenuInputSystem:requires()
  return {}
end

return MenuInputSystem
