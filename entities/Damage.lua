local Position, Circle, IsEnemy, Velocity, Color, Collider, Timer =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Color", "Collider", "Timer"})

function createDamage(parent)
  local entity = Entity(parent)
  position = parent:get("Position")
  entity:add(Position(position.x, position.y))
  circle = parent:get("Circle")
  entity:add(Color(255, 0, 0))
  entity:add(Circle(circle.radius + 2))
  entity:add(Collider("Damage", true))
  return entity
end
