local MessageSystem = class("MessageSystem", System)

function MessageSystem:draw()
  for i, v in pairs(self.targets) do
    local text = v:get("Text")
    love.graphics.setColor(255,255,255,255)
    love.graphics.setNewFont(20)
    love.graphics.printf(debug_text, 0, 100, love.graphics.getWidth(), "center")
  end
end

function MessageSystem:requires()
  return {"Text"}
end

return MessageSystem
