local Position, Circle, Color, Collider, Damage, Follow =
  Component.load({"Position", "Circle", "Color", "Collider", "Damage", "Follow"})

function createDamageArea(position, radius, damage, parent, followParent)
  local entity = Entity(parent)
  entity:add(Position(position.x, position.y))
  entity:add(Color(255, 0, 0))
  entity:add(Circle(radius))
  entity:add(Damage(damage))
  entity:add(Collider("DamageArea", true))
  if(followParent) then
    entity:add(Follow(parent))
  end
  return entity
end
