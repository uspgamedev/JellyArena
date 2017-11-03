local Position, Circle, Color, Collider, Damage, LifeTime, Follow =
  Component.load({"Position", "Circle", "Color", "Collider", "Damage", "LifeTime", "Follow"})

function createDamageArea(position, radius, damage, parent, followParent)
  local entity = Entity(parent)
  local lifeTime = LifeTime(0.1, entity)
  entity:add(Position(position.x, position.y))
  entity:add(Color(255, 0, 0))
  entity:add(Circle(radius))
  entity:add(Damage(damage))
  entity:add(Collider("DamageArea", false))
  entity:add(lifeTime)
  lifeTime:start()
  if(followParent) then
    entity:add(Follow(parent))
  end
  return entity
end
