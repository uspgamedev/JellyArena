local CollisionSystem = class("CollisionSystem", System)

function CollisionSystem:update(dt)
  world:setCallbacks(beginContact)
  for i, v in pairs(self.targets.WindowLimited) do
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    self:checkWindowLimit(position, radius)

  end

  for i, v in pairs(self.targets.Collisions) do
    --TODO: check collision
    local position = v:get("Position")
    local collidable = v:get("Collidable")
    local velocity = v:get("Velocity")
    collidable.body:setLinearVelocity(velocity.x*1000, velocity.y*1000)
    position.x = collidable.body:getX()
    position.y = collidable.body:getY()
  end
end

function beginContact(a, b, coll)
  x, y = coll:getNormal()
  text = "colidiu!!!"
end

function CollisionSystem:requires()
  return {
    WindowLimited = { "Position", "Circle", "WindowLimited" },
    Collisions = { "Position", "Circle", "Velocity", "Collidable" }
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
