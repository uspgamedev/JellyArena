local MenuSystem = class("MenuSystem", System)

function MenuSystem:draw()
  for i, v in pairs(self.targets) do
    local title = v:get("Title")
    local background = v:get("Background")
    love.graphics.setColor(background.color.r, background.color.g, background.color.b, 255)
    love.graphics.setNewFont(20)
    love.graphics.printf(title.text, 0, 100, love.graphics.getWidth(), "center")
  end
end

function MenuSystem:requires()
  return {"Title", "Background"}
end

return MenuSystem
