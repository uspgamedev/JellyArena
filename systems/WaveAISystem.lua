local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
local Goals = require "systems/ai/Goals"
local AI = Component.load({"AI"})
local waveNumber = 0


function WaveAISystem:update(dt)
  local count = 0
  for _, p in pairs(self.targets) do
    count = count + 1
  end
  if count == 0 then
    self:createWave()
  end
end

function WaveAISystem:requires()
  return {"AI"}
end

function WaveAISystem:selectAction(effect, ai)
  local tuple = WaveController.getActionsWithEffect(effect)
  local random = math.random(1, math.floor(tuple.total))
  for action, score in pairs(tuple.actions) do
    if random <= score then
      WaveController.addCurrentActions(action)
      Log.write("wave", action)
      table.insert(ai, Actions[action])
      for _,prerequisite in pairs(Actions[action].prerequisites) do
        self:selectAction(prerequisite, ai)
      end
      return
    else
      random = random - score
    end
  end
end

function WaveAISystem:selectRandomAction(effect, ai)
  local tuple = WaveController.getActionsWithEffect(effect)
  local random = math.random(1, tuple.size)
  for action, _ in pairs(tuple.actions) do
    if random <= 1 then
      Log.write("wave", action)
      WaveController.addCurrentActions(action)
      table.insert(ai, Actions[action])
      for _,prerequisite in pairs(Actions[action].prerequisites) do
        self:selectRandomAction(prerequisite, ai)
      end
      return
    else
      random = random - 1
    end
  end
end

function WaveAISystem:createWave()
  WaveController.updateLearning()
  waveNumber = waveNumber + 1
  local waveType = math.random(1, 10)
  Log.write("wave", "\nWAVE "..waveNumber.."("..waveType.."):")
  for i = 1, 4 do
    Log.write("wave", "Enemy "..i..":")
    local ai = {Actions.Idle}

    for _, effect in pairs(Goals) do
      if waveType > waveNumber then
        self:selectRandomAction(effect, ai)
      else
        self:selectAction(effect, ai)
      end
    end

    local enemy = createDumbEnemy(i * 100, i * 100)
    enemy:add(AI(Goals, ai))
    setColor(enemy)
    getEngine():addEntity(enemy)
    getEngine():addEntity(createDashAttack(enemy))
    getEngine():addEntity(createMeleeAttack(enemy))
    getEngine():addEntity(createRangedAttack(enemy))
  end
end

function setColor(enemy)
  local action = enemy:get("AI"):getAction(Goals.Damage).name
  print(action)
  local color = enemy:get("Color")
  local hash = {0, 0, 0}
  for c in action:gmatch(".") do
    local b = c:byte()
    hash[1] = (hash[1] + b) % 256
    hash[2] = (hash[2] - b) % 256
    hash[3] = (hash[3] * b) % 256
  end
  color:set(hash[1], hash[2], hash[3])
end

return WaveAISystem
