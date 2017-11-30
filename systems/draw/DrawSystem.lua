local DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
  camera:attach()
  -- draw arena TODO: temporary
  -- love.graphics.setColor(20, 20, 20)
  -- love.graphics.rectangle("fill", 0, 0, 1000, 1000)
  local mapDefinitions = Utils.mapDefinitions
  love.graphics.draw(ImageController.getImage("map"), -mapDefinitions.xOffset, -mapDefinitions.yOffset)
  for i, v in pairs(self.targets.oldEntities) do
    local position = v:get("Position")
    local circle = v:get("Circle")
    local color = v:get("Color")
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle("fill", position.x, position.y, circle.radius)
  end
  love.graphics.setColor(255, 255, 255)
  for i, v in pairs(self.targets.animated) do
    local position = v:get("Position")
    local animation = v:get("Animation")
    local tex, quad = animation:getSprite()
    love.graphics.draw(tex, quad, position.x, position.y, 0, 1.4, 1.4, 16, 18)
  end
  camera:detach()
end

function DrawSystem:requires()
  --return {"Position", "Circle", "Color"}
  return {oldEntities = {"Position", "Circle", "Color"}, animated = {"Position", "Animation"}}
end

return DrawSystem
