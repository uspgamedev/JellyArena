local Position, Circle, Velocity, Projectile, Color, IsCollidable, WindowLimited
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "IsCollidable", "WindowLimited"})

f = function (entity)
  projectile = entity:get("Projectile")
  projectile.displacement = 9999999
end

function createBullet(x, y, direction, damage)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Velocity(direction.x, direction.y, 1000))
  entity:add(Projectile(damage, distToPix(7)))
  entity:add(Color(255, 255, 255))
  entity:add(IsCollidable())
  entity:add(WindowLimited(entity, f))
  return entity
end
