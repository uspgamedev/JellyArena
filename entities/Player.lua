local Position, Circle, IsPlayer, Velocity, Timer, HP, Color, Collider, Stats, RemainingPoints =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "Timer", "Hitpoints", "Color", "Collider", "Stats", "RemainingPoints"})

function createPlayer(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  local stats = Stats(5, 10, 5, 4, 3)
  entity:add(stats)
  entity:add(Velocity(0, 0, stats:getSpeed(10)))
  entity:add(Timer(5))
  entity:add(HP(20))
  entity:add(IsPlayer())
  entity:add(Color(255, 255, 255))
  entity:add(Collider("Player", true))
  entity:add(RemainingPoints(5))
  return entity
end
