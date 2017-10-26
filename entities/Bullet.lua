local Position, Circle, Velocity, Projectile, Color, Collider
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collider"})

function createBullet(x, y, direction, damage)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Velocity(direction.x, direction.y, 1000))
  entity:add(Projectile(damage, distToPix(7)))
  entity:add(Color(255, 255, 255))
  entity:add(Collider("Bullet", true))
  return entity
end
