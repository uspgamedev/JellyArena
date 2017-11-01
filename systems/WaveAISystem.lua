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
      LogController.write("wave", action)
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
      LogController.write("wave", action)
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
  LogController.write("wave", "\nWAVE "..waveNumber.."("..waveType.."):")
  for i = 1, 4 do
    LogController.write("wave", "Enemy "..i..":")
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
    self:setColor(enemy)
    Utils.getEngine():addEntity(enemy)
    Utils.getEngine():addEntity(createDashAttack(enemy))
    Utils.getEngine():addEntity(createMeleeAttack(enemy))
    Utils.getEngine():addEntity(createRangedAttack(enemy))
  end
end

function WaveAISystem:setColor(enemy)
  local color = enemy:get("Color")
  local hash = {0, 0, 0}
  local actions = enemy:get("AI").actions
  for _,a in ipairs(actions) do
    local action = a.name
    for c in action:gmatch(".") do
      local b = c:byte()
      hash[1] = (hash[1] + b + 15) % 256
      hash[2] = (3 * hash[2] - b) % 256
      hash[3] = ((50 + hash[3]) * b) % 256
    end
  end
  color:set(hash[1], hash[2], hash[3])
end

return WaveAISystem
