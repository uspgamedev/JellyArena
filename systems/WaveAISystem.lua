local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
local Goals = require "systems/ai/Goals"
local AI = Component.load({"AI"})

function WaveAISystem:initialize()
    System.initialize(self)
    self:reset()
    self.defaultWaitTime = 0
    self:setWaitTime(self.defaultWaitTime) -- between waves
    self.totalEnemies = 5 -- per wave
    self.spawnInterval = 0
end

function WaveAISystem:reset()
  self.waveNumber = 0
  self.state = nil
end

function WaveAISystem:setWaitTime(waitTime)
  self.waitTime = waitTime
  GameState.GameData.waveWaitTime = waitTime
end

function WaveAISystem:update(dt)
  -- check if can spawn next wave
  if curGameState == "waitingWave" then
    self:setWaitTime(self.waitTime - dt)
    if not (self.state == "waitingWave") then
      self.state = "waitingWave"
      self:setWaitTime(self.defaultWaitTime)
    end

    if self.waitTime <= 0 then
      GameState.changeGameState("ingame")
      WaveController.updateLearning()
      self.waveNumber = self.waveNumber + 1
      GameState.GameData.waveNumber = self.waveNumber
      LogController.write("wave", "\nWAVE "..self.waveNumber..":")
      self.enemiesCount = 0 -- spawned on current wave
      self.spawnCooldown = self.spawnInterval -- between two enemies spawn
    end
  end

  -- check if can start spawn
  if curGameState == "ingame" and not (self.state == "done") then
    self.state = "spawning"

    self.spawnCooldown = self.spawnCooldown - dt
    if self.spawnCooldown < 0 then
      self:spawn()
      self.spawnCooldown = self.spawnInterval
    end
  end

  -- check if all enemies were defeated
  local count = 0
  for _, p in pairs(self.targets) do
    count = count + 1
  end
  if curGameState == "ingame" and self.state == "done" and count == 0 then
    GameState.changeGameState("waitingWave")
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

function WaveAISystem:selectBestAction(effect, ai)
  local tuple = WaveController.getActionsWithEffect(effect)
  local bestAction = {action = nil, score = -1}
  for action, score in pairs(tuple.actions) do
    if score > bestAction.score then
      bestAction = {action = action, score = score}
    end
  end
  if not (bestAction.action == nil) then
    table.insert(ai, Actions[bestAction.action])
    for _,prerequisite in pairs(Actions[bestAction.action].prerequisites) do
      self:selectBestAction(prerequisite, ai)
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

function WaveAISystem:spawn()
  if self.state == "done" then
    return
  end

  self.enemiesCount = self.enemiesCount + 1
  if self.enemiesCount == self.totalEnemies then
    self.state = "done"
  end

  if self.enemiesCount == 1 and self.waveNumber >= 3 then
    self.state = "done"
  end

  local waveType = math.random(1, 10)
  LogController.write("wave", "Enemy "..(self.enemiesCount+1)..":")
  local ai = {Actions.Idle}

  for _, effect in pairs(Goals) do
    if self.waveNumber >= 3 then
      self:selectBestAction(effect, ai)
    elseif waveType > self.waveNumber then
      self:selectRandomAction(effect, ai)
    else
      self:selectAction(effect, ai)
    end
  end

  local corners = {{0,0},{0,1000},{1000,0},{1000,1000}}
  local position = math.random(1, 4)

  local enemy = nil
  if self.waveNumber < 3 then
    enemy = createDumbEnemy(corners[position][1], corners[position][2])
  else
    enemy = createBossEnemy(corners[position][1], corners[position][2])
  end

  enemy:add(AI(Goals, ai))
  self:setColor(enemy)
  local engine = Utils.getEngine()
  engine:addEntity(enemy)

  for _, action in pairs(enemy:get("AI").actions) do
    for _, entityName in pairs(action.requiredChildrenEntities) do
      engine:addEntity(DefaultAttackConstructors[entityName](enemy))
    end
  end
  -- engine:addEntity(createDashAttack(enemy))
  -- engine:addEntity(createMeleeAttack(enemy))
  -- engine:addEntity(createRangedAttack(enemy))
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
