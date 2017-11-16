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

local Enemy = {}

function Enemy.baseEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
  entity:add(Color(0, 0, 0))  
  return entity
end

function Enemy.setNormal(entity)
  entity:add(Circle(20))
end

function Enemy.setBoss(entity)
  entity:add(Circle(60))
end

function Enemy.setAI(entity, goals, actions)
  entity:add(AI(goals, actions))
end

function Enemy.setHitpoints(entity, hp)
  entity:add(Hitpoints(hp))
end

function Enemy.createDumbEnemy(x, y)
  local entity = Enemy.baseEnemy(x, y)
  Enemy.setNormal(entity)
  Enemy.setHitpoints(entity, 10)
  local stats = Stats(1, 1, 1, 1, 2)
  entity:add(stats)
  entity:add(Velocity(0, 0, stats:getSpeed()))
  return entity
end

function Enemy.createBossEnemy(x, y)
  local entity = Enemy.baseEnemy(x, y)
  Enemy.setBoss(entity)
  Enemy.setHitpoints(entity, 50)
  local stats = Stats(1, 5, 5, 5, 5)
  entity:add(stats)
  entity:add(Velocity(0, 0, stats:getSpeed()))
  return entity
end

return Enemy
