local Velocity = Component.create("Velocity")

function Velocity:initialize(x, y, maxSpeed)
  self.x = x
  self.y = y
  self.maxSpeed = maxSpeed
  self.speed = maxSpeed
end

function Velocity:getDirection()
  return Vector(self.x, self.y)
end

function Velocity:setDirection(vector)
  normalizedVector = vector:normalized()
  self.x = normalizedVector.x
  self.y = normalizedVector.y
end

function Velocity:toVector()
  return self:getDirection() * self.speed
end
