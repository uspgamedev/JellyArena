local Position,
  Circle,
  AI,
  Hitpoints,
  Velocity,
  Stats,
  Color,
  Collider,
  Timer = Component.load({"Position", "Circle", "AI", "Hitpoints", "Velocity", "Stats", "Color", "Collider", "Timer"})

local Actions = require "systems/ai/Actions"

function createDumbEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Hitpoints(10))
  entity:add(Velocity(0, 0, Utils.getSpeed(1)))
  entity:add(Stats(1, 1, 1, 1, 2))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end
