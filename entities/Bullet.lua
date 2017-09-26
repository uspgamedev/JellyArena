local Position, Circle, Velocity, Projectile, Color, Collider
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collider"})

function createBullet(entity, x, y, direction, damage)
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Velocity(direction.x, direction.y, 1000))
  entity:add(Color(255, 255, 255))
end

function createPlayerBullet(x, y, direction, damage)
  local entity = Entity()
  createBullet(entity, x, y, direction, damage)
  entity:add(Projectile("Player", damage, distToPix(7)))
  entity:add(Collider("PlayerBullet", true))
  return entity
end

function createEnemyBullet (x, y, direction, damage)
  local entity = Entity()
  createBullet(entity, x, y, direction, damage)
  entity:add(Projectile("Enemy", damage, distToPix(7)))
  entity:add(Collider("EnemyBullet", true))
  return entity
end
