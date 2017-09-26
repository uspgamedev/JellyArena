local DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
  for i, v in pairs(self.targets) do
    local position = v:get("Position")
    local circle = v:get("Circle")
    local color = v:get("Color")
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle("fill", position.x, position.y, circle.radius)
  end
end

function DrawSystem:requires()
  return {"Position", "Circle", "Color"}
end

return DrawSystem
