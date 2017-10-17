local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
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
  local actions = WaveController.getActionsWithEffect(effect)
  local random = math.random()
  for action, prob in pairs(actions) do
    if random <= prob then
      WaveController.addCurrentActions(action)
      table.insert(ai, Actions[action])
      for _,prerequisite in pairs(Actions[action].prerequisites) do
        self:selectAction(prerequisite, ai)
      end
      return
    else
      random = random - prob
    end
  end
end

function WaveAISystem:selectRandomAction(effect, ai)
  local actions = WaveController.getActionsWithEffect(effect)
  local random = math.random()
  local prob = 1.0 / WaveController.getActionsWithEffectSize(effect)
  for action, _ in pairs(actions) do
    if random <= prob then
      WaveController.addCurrentActions(action)
      table.insert(ai, Actions[action])
      for _,prerequisite in pairs(Actions[action].prerequisites) do
        self:selectRandomAction(prerequisite, ai)
      end
      return
    else
      random = random - prob
    end
  end
end

function WaveAISystem:createWave()
  WaveController.updateLearning()
  waveNumber = waveNumber + 1
  waveType = math.random(1, 10)
  for i = 1, 4 do
    local ai = {Actions.Idle}
    local effect = {name = "Damage"}
    if waveType > waveNumber then
      self:selectRandomAction(effect, ai)
    else
      self:selectAction(effect, ai)
    end
    local enemy = createDumbEnemy(i * 100, i * 100)
    enemy:add(AI(effect, ai))
    engine:addEntity(enemy)
    engine:addEntity(createDashAttack(enemy))
    engine:addEntity(createMeleeAttack(enemy))
    engine:addEntity(createRangedAttack(enemy))
  end
  
end

return WaveAISystem
