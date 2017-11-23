local Position,
  Circle,
  AI,
  Hitpoints,
  Velocity,
  Level,
  Color,
  Collider,
  Timer = Component.load({"Position", "Circle", "AI", "Hitpoints", "Velocity", "Level", "Color", "Collider", "Timer"})

local Actions = require "systems/ai/Actions"

local Enemy = {}

function Enemy.baseEnemy(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Collider("Enemy", true))
  entity:add(Timer(0.5))
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

function Enemy.setBaseHitpoints(entity, hp)
  entity:add(Hitpoints(hp))
end

function Enemy.addBonusHitpoints(entity, bonus)
  entity:get("Hitpoints"):add(bonus)
end

function Enemy.setLevel(entity, level)
  entity:add(Level(level))
end

function Enemy.setSpeed(entity, speed)
  if entity:has("Velocity") then
    local current = entity:get("Velocity")
    current.maxSpeed = (current.maxSpeed + speed) / 2
  else
    entity:add(Velocity(0, 0, speed))
  end
end

function Enemy.setColor(enemy)
  local hash = {0, 0, 0}
  local actions = enemy:get("AI").actions
  for _, a in ipairs(actions) do
    local action = a.name
    for c in action:gmatch(".") do
      local b = c:byte()
      hash[1] = (hash[1] + b + 15) % 256
      hash[2] = (3 * hash[2] - b + hash[1]) % 256
      hash[3] = ((50 + hash[3]) * b + hash[2]) % 256
    end
  end
  enemy:add(Color(hash[1], hash[2], hash[3]))
end

return Enemy
