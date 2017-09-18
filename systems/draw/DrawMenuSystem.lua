local DrawMenuSystem = class("DrawMenuSystem", System)

function DrawMenuSystem:draw()
  for i, v in pairs(self.targets) do
    local title = v:get("Title")
    local background = v:get("Background")
    love.graphics.setColor(background.color.r, background.color.g, background.color.b, 200)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setNewFont(20)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(title.text, 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf(debug_text, 0, 200, love.graphics.getWidth(), "center")
  end
end

function DrawMenuSystem:requires()
  return {"Title", "Background"}
end

return DrawMenuSystem
