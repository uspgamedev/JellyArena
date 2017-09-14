local Position, Circle, IsEnemy, Velocity, Color, Collider =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Color", "Collider"})

function createEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(IsEnemy("FollowPlayer"))
  entity:add(Color(0, 255, 255))
  entity:add(Collider(true))
  return entity
end
