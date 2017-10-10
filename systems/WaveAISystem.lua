local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
local AI = Component.load({"AI"})

function WaveAISystem:update(dt)
  local count = 0
  for _, p in pairs(self.targets) do
    count = count + 1
  end
  if count == 0 then
    createWave()
  end
end

function WaveAISystem:requires()
  return {"AI"}
end

function selectAction(effect, ai)
  local actions = getActionsWithEffect(effect)
  local random = math.random()
  for action, prob in pairs(actions) do
    if random <= prob then
      table.insert(ai, Actions[action])
      for _,prerequisite in pairs(Actions[action].prerequisites) do
        selectAction(prerequisite, ai)
      end
      return
    else
      random = random - prob
    end
  end
end

function createWave()
  for i = 1, 4 do
    local ai = {Actions.Idle}
    local effect = {name = "Damage"}
    selectAction(effect, ai)
    for k,v in pairs(ai) do
      print(k,v)
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
