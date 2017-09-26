local Position, Circle, Color, Collider =
  Component.load({"Position", "Circle", "Color", "Collider"})

function createDamage(parent)
  local entity = Entity(parent)
  local position = parent:get("Position")
  entity:add(Position(position.x, position.y))
  local circle = parent:get("Circle")
  entity:add(Color(255, 0, 0))
  entity:add(Circle(circle.radius + 2))
  entity:add(Collider("Damage", true))
  return entity
end
