local Position, Circle, IsPlayer, Velocity, AttackProperties, Timer, HP, Color, Collider, Stats =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "AttackProperties", "Timer", "Hitpoints", "Color", "Collider", "Stats"})

function createPlayer(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, getSpeed(10)))
  entity:add(HP(20))
  entity:add(IsPlayer())
  entity:add(Color(255, 255, 255))
  entity:add(Collider("Player", true))
  entity:add(Stats(2, 10, 5, 4, 3))
  return entity
end
