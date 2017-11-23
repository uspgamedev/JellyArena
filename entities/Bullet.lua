local Position, Circle, Velocity, Projectile, Color, Collider
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collider"})

function createBullet(entity, x, y, direction, damage, speed, radius)
  entity:add(Position(x, y))
  entity:add(Circle(radius))
  entity:add(Velocity(direction.x, direction.y, speed))
end

function createPlayerBullet(x, y, direction, damage, range, speed)
  local entity = Entity()
  entity:add(Color(255, 255, 255))
  createBullet(entity, x, y, direction, damage, speed, 5)
  entity:add(Projectile("Player", damage, range))
  entity:add(Collider("PlayerBullet", true))
  return entity
end

function createEnemyBullet (parent, x, y, direction, damage, range, speed, radius)
  local entity = Entity(parent)
  entity:add(Color(255, 255, 0))
  createBullet(entity, x, y, direction, damage, speed, radius)
  entity:add(Projectile("Enemy", damage, range))
  entity:add(Collider("EnemyBullet", false))
  return entity
end
