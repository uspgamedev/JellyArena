local MenuInputSystem = class("MenuInputSystem", System)
local COOLDOWN = 0.2
local timer = COOLDOWN

function MenuInputSystem:update(dt)
  if timer >= COOLDOWN then
    if (love.keyboard.isDown("down")) then
      nextMenuItem()
      playSound("teste")
      timer = 0
    elseif (love.keyboard.isDown("up")) then
      previousMenuItem()
      playSound("teste")
      timer = 0
    elseif (love.keyboard.isDown("return")) then
      selectMenuitem()
      playSound("teste")
      timer = 0
    end
  else
    timer = timer + dt
  end
end

function MenuInputSystem:requires()
  return {}
end

return MenuInputSystem
