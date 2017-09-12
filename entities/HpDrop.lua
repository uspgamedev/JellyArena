local Position, Circle, Color, IsCollidable, WindowLimited =
  Component.load({"Position", "Circle", "Color", "IsCollidable", "WindowLimited"})

function createHpDrop(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(5))
  entity:add(Color(255, 0, 0))
  entity:add(IsCollidable())
  entity:add(WindowLimited())
  return entity
end
