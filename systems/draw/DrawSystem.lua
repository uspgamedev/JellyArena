local DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
  camera:attach()
  -- draw arena TODO: temporary
  -- love.graphics.setColor(20, 20, 20)
  -- love.graphics.rectangle("fill", 0, 0, 1000, 1000)
  local mapDefinitions = Utils.mapDefinitions
  love.graphics.draw(ImageController.getImage("map"), -mapDefinitions.xOffset, -mapDefinitions.yOffset)
  --[[for i, v in pairs(self.targets.oldEntities) do
    local position = v:get("Position")
    local circle = v:get("Circle")
    local color = v:get("Color")
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle("fill", position.x, position.y, circle.radius)
  end
  love.graphics.setColor(255, 255, 255)--]]
  for i, v in pairs(self.targets) do
    local position = v:get("Position")
    local animation = v:get("Animation")
    local circle = v:get("Circle")
    local tex, quad = animation:getSprite()
    local x, y, w, h = quad:getViewport()
    w = w / 2;
    h = h / 2;
    local xScale = circle.radius / w
    local ySclae = circle.radius / h
    love.graphics.draw(tex, quad, position.x, position.y, animation.rotation, xScale, yScale, w, h)
  end
  camera:detach()
end

function DrawSystem:requires()
  return {"Position", "Animation", "Circle"}
  --return {oldEntities = {"Position", "Circle", "Color"}, animated = {"Position", "Animation", "Circle"}}
end

return DrawSystem
