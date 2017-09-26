local Position, Circle, Color, Collider =
  Component.load({"Position", "Circle", "Color", "Collider"})

function createHpDrop(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Color(255, 0, 0))
  entity:add(Collider("HpDrop", true))
  return entity
end
