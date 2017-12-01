local Position, Circle, Velocity, Projectile, Color, Collider, Animation
  = Component.load({"Position", "Circle", "Velocity", "Projectile", "Color", "Collider", "Animation"})

function createBullet(entity, x, y, direction, damage, speed, radius)
  entity:add(Position(x, y))
  entity:add(Circle(radius))
  entity:add(Velocity(direction.x, direction.y, speed))
  entity:add(Animation(ImageController.getAnimation("bullet", 1, 1, 8, 1)))
end

local function setBulletColor(entity, parentColor)
  local red = math.floor(parentColor.r * 0.8)
  local green = math.floor(parentColor.g * 0.8)
  local blue = math.floor(parentColor.b * 0.8)
  entity:set(Color(red, green, blue))
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
  setBulletColor(entity, parent:get("Color"))
  createBullet(entity, x, y, direction, damage, speed, radius)
  entity:add(Projectile("Enemy", damage, range))
  entity:add(Collider("EnemyBullet", false))
  return entity
end
