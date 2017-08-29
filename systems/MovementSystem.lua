local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
  for i, v in pairs(self.targets) do
    local velocity = v:get("Velocity")
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    position:setVector(position:toVector() + velocity:toVector() * dt)
    self:checkWindowLimit(position, radius)
  end
end

function MovementSystem:checkWindowLimit(position, radius)
  window_width = love.graphics.getWidth() - radius
  window_height = love.graphics.getHeight() - radius

  if position.x < radius then
    position.x = radius
  elseif position.x > window_width then
    position.x = window_width
  end

  if position.y < radius then
    position.y = radius
  elseif position.y > window_height then
    position.y = window_height
  end
end

function MovementSystem:requires()
  return {"Position", "Velocity", "Circle"}
end

return MovementSystem
