local MenuInputSystem = class("MenuInputSystem", System)
local COOLDOWN = 0.18
local timer = COOLDOWN

function MenuInputSystem:update(dt)
  if timer >= COOLDOWN then
    if (love.keyboard.isDown("down")) then
      MenuController.nextMenuItem()
      SoundController.playSound("select")
      timer = 0
    elseif (love.keyboard.isDown("up")) then
      MenuController.previousMenuItem()
      SoundController.playSound("select")
      timer = 0
    elseif (love.keyboard.isDown("return")) then
      MenuController.selectMenuitem()
      SoundController.playSound("select")
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
