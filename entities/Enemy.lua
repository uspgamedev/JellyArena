local Position, Circle, IsEnemy, Velocity, Color =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Color"})

function createEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(IsEnemy("FollowPlayer"))
  entity:add(Color(0, 255, 255))
  return entity
end
