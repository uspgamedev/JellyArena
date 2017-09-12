local Position, Circle, Color =
  Component.load({"Position", "Circle", "Color"})

function createHpDrop(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Color(255, 0, 0))
  return entity
end
