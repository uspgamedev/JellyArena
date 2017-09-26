local Position, Circle, IsEnemy, Velocity, Color, Collider, Timer =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Color", "Collider", "Timer"})

function createEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(IsEnemy("FollowPlayer", "Melee"))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end
