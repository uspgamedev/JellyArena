local DrawMenuSystem = class("DrawMenuSystem", System)

background = { r = 0, g = 0, b  = 0}

function DrawMenuSystem:draw()
  love.graphics.setColor(background.r, background.g, background.b, 200)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setNewFont(20)
  love.graphics.setColor(255, 255, 255, 255)
--  love.graphics.printf(title.text, 0, 100, love.graphics.getWidth(), "center")
  love.graphics.printf(debug_text, 0, 200, love.graphics.getWidth(), "center")
end



return DrawMenuSystem
