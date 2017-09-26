local Position, Circle, AI, Velocity, Color, Collider, Timer =
  Component.load({"Position", "Circle", "AI", "Velocity", "Color", "Collider", "Timer"})

local Actions = require "systems/ai/Actions"

function createEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(AI({ name = "Damage" }, { Actions.RangedAttack, Actions.FollowPlayer }))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end
