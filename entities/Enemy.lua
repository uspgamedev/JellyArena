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
  entity:add(Velocity(0, 0, getSpeed(1)))
  entity:add(Stats(2, 1, 20, 10, 20))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end

function createDashEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Hitpoints(10))
  entity:add(Velocity(0, 0, 200))
  entity:add(Stats(1, 10, 20, 10, 10))
  entity:add(AI({name = "Damage"}, {Actions.MeleeAttack, Actions.DashAttack, Actions.FollowPlayer}))
  entity:add(Color(0, 255, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end

function createMeleeEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Hitpoints(15))
  entity:add(Velocity(0, 0, 200))
  entity:add(Stats(1, 10, 20, 10, 10))
  entity:add(AI({name = "Damage"}, {Actions.MeleeAttack, Actions.FollowPlayer}))
  entity:add(Color(255, 0, 255))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end

function createRangedEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Hitpoints(5))
  entity:add(Velocity(0, 0, 200))
  entity:add(Stats(1, 10, 20, 10, 10))
  entity:add(AI({name = "Damage"}, {Actions.RangedAttack, Actions.FleeFromPlayer, Actions.FollowPlayer}))
  entity:add(Color(255, 255, 0))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end

function createHybridEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Hitpoints(10))
  entity:add(Velocity(0, 0, 200))
  entity:add(Stats(1, 10, 20, 10, 10))
  entity:add(AI({name = "Damage"}, {Actions.RangedAttack, Actions.FollowPlayer, Actions.MeleeAttack, Actions.FleeFromPlayer, Actions.DashAttack}))
  entity:add(Color(255, 255, 127))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  return entity
end
