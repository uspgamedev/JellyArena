local Bullet = class("Bullet", Entity)
local Position, Circle, Velocity, Projectile, Color, Collidable
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collidable"})

function Bullet:initialize(x, y, direction, damage)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(5))
  self:add(Velocity(direction.x, direction.y, 1000))
  self:add(Projectile(damage, distToPix(7)))
  self:add(Color(255, 255, 255))
  self:add(Collidable(world, x, y, 5))
end

return Bullet
