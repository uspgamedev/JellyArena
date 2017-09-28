local Position, Circle, Velocity, Projectile, Color, Collider
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collider"})

function createBullet(entity, x, y, direction, damage)
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Velocity(direction.x, direction.y, 1000))
end

function createPlayerBullet(x, y, direction, damage, range)
  local entity = Entity()
  entity:add(Color(255, 255, 255))
  createBullet(entity, x, y, direction, damage)
  entity:add(Projectile("Player", damage, range))
  entity:add(Collider("PlayerBullet", true))
  return entity
end

function createEnemyBullet (x, y, direction, damage, range)
  local entity = Entity()
  entity:add(Color(255, 255, 0))
  createBullet(entity, x, y, direction, damage)
  entity:add(Projectile("Enemy", damage, range))
  entity:add(Collider("EnemyBullet", false))
  return entity
end
