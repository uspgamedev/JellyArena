local Bullet = class("Bullet", Entity)
local Position, Circle, Velocity, Projectile
  = Component.load({"Position", "Circle", "Velocity", "Projectile"})

function Bullet:initialize(x, y, direction, damage)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(5))
  self:add(Velocity(direction.x, direction.y, 1000))
  self:add(Projectile(damage))
end

return Bullet
