local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
local Goals = require "systems/ai/Goals"
local AI = Component.load({"AI"})

function WaveAISystem:initialize()
    System.initialize(self)
    self.waveNumber = 0
    self.state = nil
    self.waitTime = 3
end

function WaveAISystem:update(dt)
  -- check if can spawn next wave
  if curGameState == "waitingWave" then
    self.waitTime = self.waitTime - dt
    if not (self.state == "waitingWave") then
      self.state = "waitingWave"
      self.waitTime = 3
    end

    if self.waitTime <= 0 then
      changeGameState("ingame")
    end
  end

  -- check if can start spawn
  if curGameState == "ingame" and not (self.state == "spawning") and not (self.state == "done") then
    self.state = "spawning"
    self:createWave()
    self.state = "done"
  end

  -- check if all enemies were defeated
  local count = 0
  for _, p in pairs(self.targets) do
    count = count + 1
  end
  if curGameState == "ingame" and self.state == "done" and count == 0 then
    changeGameState("waitingWave")
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
  self.waveNumber = self.waveNumber + 1
  local waveType = math.random(1, 10)
  Log.write("wave", "\nWAVE "..self.waveNumber.."("..waveType.."):")
  for i = 1, 4 do
    Log.write("wave", "Enemy "..i..":")
    local ai = {Actions.Idle}

    for _, effect in pairs(Goals) do
      print(effect.name)
      if waveType > self.waveNumber then
        self:selectRandomAction(effect, ai)
      else
        self:selectAction(effect, ai)
      end
    end

    local enemy = createDumbEnemy(i * 100, i * 100)
    enemy:add(AI(Goals, ai))
    getEngine():addEntity(enemy)
    getEngine():addEntity(createDashAttack(enemy))
    getEngine():addEntity(createMeleeAttack(enemy))
    getEngine():addEntity(createRangedAttack(enemy))
  end

end

return WaveAISystem
