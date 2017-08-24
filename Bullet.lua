local Bullet = class("Bullet", Entity)
local Position, Circle, Velocity = Component.load({"Position", "Circle", "Velocity"})

function Bullet:initialize(x, y, direction)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(5))
  self:add(Velocity(direction.x, direction.y, 1000))
end

return Bullet
