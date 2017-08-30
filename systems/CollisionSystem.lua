local CollisionSystem = class("CollisionSystem", System)

function CollisionSystem:update(dt)
  for i, v in pairs(self.targets.WindowLimited) do
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    self:checkWindowLimit(position, radius)
  end

  for i, v in pairs(self.targets.Collisions) do
    --TODO: check collision
  end
end

function CollisionSystem:requires()
  return {
    WindowLimited = { "Position", "Circle", "WindowLimited" },
    Collisions = { "Position", "Circle", "Velocity" }
  }
end

function CollisionSystem:checkWindowLimit(position, radius)
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

return CollisionSystem
