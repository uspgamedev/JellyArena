local WaveAISystem = class("WaveAISystem", System)
local Actions = require "systems/ai/Actions"
local Goals = require "systems/ai/Goals"

local Animation = Component.load({"Animation"});

function WaveAISystem:initialize()
  System.initialize(self)
  self:reset()
  self.defaultWaitTime = 3
  self:setWaitTime(self.defaultWaitTime) -- between waves
  self.totalEnemies = 10 -- per wave
  self.spawnInterval = 1
  self.finalWave = 10
  self.waveTime = 0
end

function WaveAISystem:reset()
  self.waveNumber = 0
  self.state = nil
  self.waveTime = 0
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
      StatisticController.add(math.sqrt(self.waveTime))
      WaveController.updateLearning(self.waveNumber)
      self.waveNumber = self.waveNumber + 1
      GameState.GameData.waveNumber = self.waveNumber
      LogController.write("wave", "\nWAVE " .. self.waveNumber .. ":")
      self.enemiesCount = 0 -- spawned on current wave
      self.spawnCooldown = self.spawnInterval -- between two enemies spawn
      self.waveTime = 0
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
    if self.waveNumber == self.finalWave then
      GameState.changeGameState("victoryMenu")
      return
    end

    GameState.changeGameState("waitingWave")
    if self.waveNumber == self.finalWave-1 then
      SoundController.setTrack("boss")
    end
    Utils.addPlayerPoints(2)
  end
  self.waveTime = self.waveTime + dt
end

function WaveAISystem:requires()
  return {"AI"}
end

function WaveAISystem:selectAction(effect, ai)
  local tuple = WaveController.getActionsWithEffect(effect)
  local random = math.random(0, math.floor(tuple.total))
  for action, score in pairs(tuple.actions) do
    if random <= score then
      WaveController.addCurrentActions(action)
      LogController.write("wave", action)
      table.insert(ai, Actions[action])
      for _, prerequisite in pairs(Actions[action].prerequisites) do
        self:selectAction(prerequisite, ai)
      end
      return
    else
      random = random - score
    end
  end
end

function WaveAISystem:selectBestActions(effect, ai, maxCount)
  local tuple = WaveController.getActionsWithEffect(effect)
  local actionCount = 0
  for action, score in Utils.pairsOrderValuesDesc(tuple.actions) do
    table.insert(ai, Actions[action])
    for _, prerequisite in pairs(Actions[action].prerequisites) do
      self:selectBestActions(prerequisite, ai, 1)
    end
    actionCount = actionCount + 1
    if actionCount == maxCount then
      break
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
      for _, prerequisite in pairs(Actions[action].prerequisites) do
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

  if self.enemiesCount == 1 and self.waveNumber >= self.finalWave then
    self.state = "done"
  end

  local waveType = math.random(1, 10)
  LogController.write("wave", "Enemy " .. (self.enemiesCount + 1) .. ":")
  local ai = {Actions.Idle}

  for _, effect in pairs(Goals) do
    if self.waveNumber >= self.finalWave then
      self:selectBestActions(effect, ai) -- Boss
    elseif waveType > self.waveNumber then
      self:selectRandomAction(effect, ai)
    else
      self:selectAction(effect, ai)
    end
  end

  self:createEnemy(Goals, ai)
end

function WaveAISystem:createEnemy(Goals, ai)
  local mapSize = Utils.mapDefinitions
  local corners = {{0, 0}, {0, mapSize.height}, {mapSize.width, 0}, {mapSize.width, mapSize.height}}
  local position = math.random(1, 4)

  local enemy = Enemy.baseEnemy(corners[position][1], corners[position][2])
  Enemy.setAI(enemy, Goals, ai)
  if self.waveNumber < self.finalWave then
    Enemy.setNormal(enemy)
    Enemy.setBaseHitpoints(enemy, 5)
    if self.waveNumber <= self.finalWave / 2 then
      Enemy.setLevel(enemy, 1)
    else
      Enemy.setLevel(enemy, 2)
    end

    local melee = false
    local ranged = false

    for _, a in ipairs(ai) do
      local action = a.name

      if(action:find("Ranged")) then ranged = true
      elseif(action:find("Melee")) then melee = true
      elseif(action:find("Dash")) then melee = true
      end
    end

    if(melee and not ranged) then
      Enemy.setAnimation(enemy, Animation(ImageController.getAnimation("charger", 2, 0.4)))
    elseif(not melee and ranged) then
      Enemy.setAnimation(enemy, Animation(ImageController.getAnimation("shooter", 2, 0.4)))
    elseif(melee and ranged) then
      Enemy.setAnimation(enemy, Animation(ImageController.getAnimation("hybrid", 2, 0.4)))
    else
      Enemy.setAnimation(enemy, Animation(ImageController.getAnimation("dummy", 2, 0.4)))
    end

    SoundController.setTrack("waves")
  else
    Enemy.setBoss(enemy)
    Enemy.setBaseHitpoints(enemy, 20)
    Enemy.setLevel(enemy, 3)
    Enemy.setAnimation(enemy, Animation(ImageController.getAnimation("boss", 2, 0.4, 64)))
  end

  Enemy.setColor(enemy)
  local engine = Utils.getEngine()
  engine:addEntity(enemy)


  -- add attacks to engine
  for _, action in pairs(enemy:get("AI").actions) do
    for _, entityName in pairs(action.requiredChildrenEntities) do
      engine:addEntity(DefaultAttackConstructors[entityName](enemy))
    end
  end
end

return WaveAISystem
