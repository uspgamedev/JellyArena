local Position, Circle, IsPlayer, Velocity, AttackProperties, Timer, HP, Color, Collider, Stats =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "AttackProperties", "Timer", "Hitpoints", "Color", "Collider", "Stats"})

function createPlayer(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 500))
  entity:add(AttackProperties(5, 25))
  entity:add(HP(20))
  entity:add(Timer(0.3))
  entity:add(IsPlayer())
  entity:add(Color(255, 255, 255))
  entity:add(Collider("Player", true))
  entity:add(Stats(2, 10, 20, 10, 10))
  return entity
end
