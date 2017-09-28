local Position, Circle, AI, Velocity, Color, Collider, Timer =
  Component.load({"Position", "Circle", "AI", "Velocity", "Color", "Collider", "Timer"})

local Actions = require "systems/ai/Actions"

function createEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(AI({ name = "Damage" }, { Actions.MeleeAttack, Actions.RangedAttack, Actions.FollowPlayer }))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  return entity
end

function createMeleeEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(AI({ name = "Damage" }, { Actions.MeleeAttack, Actions.FollowPlayer }))
  entity:add(Color(255, 0, 255))
  entity:add(Collider("Enemy", true))
  return entity
end

function createRangedEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 200))
  entity:add(AI({ name = "Damage" }, { Actions.RangedAttack, Actions.FollowPlayer }))
  entity:add(Color(255, 255, 0))
  entity:add(Collider("Enemy", true))
  return entity
end
