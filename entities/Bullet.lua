local Position, Circle, Velocity, Projectile, Color, Collidable
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collidable"})

function createBullet(x, y, direction, damage)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Velocity(direction.x, direction.y, 1000))
  entity:add(Projectile(damage, distToPix(7)))
  entity:add(Color(255, 255, 255))
  entity:add(Collidable(world, x, y, 5))
  return entity
end
