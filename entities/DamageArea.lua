local Position, Circle, Color, Collider, Damage =
  Component.load({"Position", "Circle", "Color", "Collider", "Damage"})

function createDamageArea(position, radius, damage)
  local entity = Entity()
  entity:add(Position(position.x, position.y))
  entity:add(Color(255, 0, 0))
  entity:add(Circle(radius))
  entity:add(Damage(damage))
  entity:add(Collider("DamageArea", true))
  return entity
end
