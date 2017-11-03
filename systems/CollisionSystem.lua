local CollisionSystem = class("CollisionSystem", System)

function CollisionSystem:initialize()
  System.initialize(self)

  self.collisionPairs = {}
  self.collisionPairsCount = 0

  self.entitiesToRemove = {}
  self.entitiesToRemoveCount = 0
end

function CollisionSystem:update(dt)
  -- Check screen bounds, reposition or remove entities
  for i, v in pairs(self.targets) do
    local collider = v:get("Collider")
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    -- Delete entities that have gone outside stage bounds
    if (self:checkStageBounds(position, radius) and not collider.clampToStageBounds) then
      collider.active = false
      self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
      self.entitiesToRemove[self.entitiesToRemoveCount] = v
    end
  end

  -- Generate collision pairs
  for i, v in pairs(self.targets) do
    local vCollider = v:get("Collider")

    if (vCollider.active) then
      local vPos = v:get("Position"):toVector()
      local vRad = v:get("Circle").radius

      for j, w in pairs(self.targets) do
        if (j > i) then
          local wCollider = w:get("Collider")

          if (wCollider.active) then
            -- TODO: change to a shape intersection test

            local wPos = w:get("Position"):toVector()
            local wRad = w:get("Circle").radius

            local dist = (vPos - wPos):len2()
            local minDist = (vRad + wRad) * (vRad + wRad)

            if (dist < minDist) then
              self.collisionPairsCount = self.collisionPairsCount + 1
              self.collisionPairs[self.collisionPairsCount] = {[vCollider.type] = v, [wCollider.type] = w}
            end
          end
        end
      end
    end
  end

  -- Resolve collision pairs
  for _, pair in pairs(self.collisionPairs) do
    -- TODO: handle each pair type

    local resolved = false
    for _, entity in pairs(pair) do
      resolved = resolved or entity:get("Collider").resolved
    end

    if not resolved then
      if (pair["Player"] and pair["HpDrop"]) then
        self:PlayerAndHpDrop(pair)
      elseif (pair["Enemy"] and pair["PlayerBullet"]) then
        self:PlayerBulletAndEnemy(pair)
      elseif (pair["Player"] and pair["DamageArea"]) then
        self:PlayerAndDamageArea(pair)
      elseif (pair["Player"] and pair["EnemyBullet"]) then
        self:PlayerAndEnemyBullet(pair)
      elseif (pair["Player"] and pair["Trap"]) then
        self:PlayerAndTrap(pair)
      elseif (pair["Player"] and pair["Enemy"]) then
        self:PlayerAndEnemy(pair)
      end
    end

    -- lovetoys.debug("BATEU: "..v.id..":"..w.id)
    -- debugText = "BATEU: "..v.id..":"..w.id
  end

  -- Clean collisionPairs array
  for i = 1, self.collisionPairsCount, 1 do
    local pair = self.collisionPairs[i]
    for _, entity in pairs(pair) do
      entity:get("Collider").resolved = false
    end
    self.collisionPairs[i] = nil
  end
  self.collisionPairsCount = 0

  -- Remove flagged entities
  for i = 1, self.entitiesToRemoveCount, 1 do
    Utils.getEngine():removeEntity(self.entitiesToRemove[i], true)
    self.entitiesToRemove[i] = nil
  end
  self.entitiesToRemoveCount = 0
end

function CollisionSystem:requires()
  return {"Collider"}
end

function CollisionSystem:checkStageBounds(position, radius)
  -- TODO: change to stage bounds instead of window bounds
  local size = {["x"] = 1000 - radius, ["y"] = 1000 - radius}
  local check = false
  if position.x < radius then
    check = true
    position.x = radius
  elseif position.x > size.x then
    check = true
    position.x = size.x
  end

  if position.y < radius then
    check = true
    position.y = radius
  elseif position.y > size.y then
    check = true
    position.y = size.y
  end

  return check
end

function CollisionSystem:PlayerAndHpDrop(pair)
  local player = pair["Player"]
  local drop = pair["HpDrop"]
  local hp = player:get("Hitpoints")

  hp:add(1)
  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = drop
end

function CollisionSystem:PlayerAndTrap(pair)
  local player = pair["Player"]
  local trap = pair["Trap"]
  local trapType = trap:get("Label").label

  if (trapType == "DamageTrap") then
    if (player:get("Hitpoints").cur >= 10) then
      player:get("Hitpoints").cur = player:get("Hitpoints").cur - 10
    else
      player:get("Hitpoints").cur = 0
      changeGameState("gameOver")
    end
  elseif (trapType == "HealingTrap") then
    player:get("Hitpoints"):add(10)
  else
    math.randomseed(os.time())
    self:PushPlayer(player, math.random(4), 200)
  end

  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = trap
end

function CollisionSystem:PushPlayer(player, direction, displacement)
  if (direction == 1) then
    player:get("Position").y = player:get("Position").y - displacement
  elseif (direction == 2) then
    player:get("Position").x = player:get("Position").x + displacement
  elseif (direction == 3) then
    player:get("Position").y = player:get("Position").y + displacement
  elseif (direction == 4) then
    player:get("Position").x = player:get("Position").x - displacement
  end
  if (player:get("Position").x < 0) then
    player:get("Position").x = 0
  end
  if (player:get("Position").y < 0) then
    player:get("Position").y = 0
  end
  if (player:get("Position").x > love.graphics.getWidth()) then
    player:get("Position").x = love.graphics.getWidth() - player:get("Circle").radius
  end
  if (player:get("Position").y > love.graphics.getHeight()) then
    player:get("Position").y = love.graphics.getHeight() - player:get("Circle").radius
  end
end

function CollisionSystem:PlayerBulletAndEnemy(pair)
  local bullet = pair["PlayerBullet"]
  local enemy = pair["Enemy"]
  local enemyHp = enemy:get("Hitpoints")
  local bulletDamage = bullet:get("Projectile").damage
  self:killAndDrop(bullet)
  bullet:get("Collider").resolved = true
  if (enemyHp.cur - bulletDamage > 0) then
    enemyHp.cur = enemyHp.cur - bulletDamage
  else
    self:killAndDrop(enemy)
  end
end

function CollisionSystem:PlayerAndDamageArea(pair)
  local player = pair["Player"]
  local damage = pair["DamageArea"]
  local parent = damage:getParent()
  StatisticController.addToActions(damage:get("Damage").damage * parent:get("Stats").damage, parent:get("AI").actions)

  self:DamagePlayer(player, damage:get("Damage").damage * parent:get("Stats").damage)
end

function CollisionSystem:PlayerAndEnemyBullet(pair)
  local player = pair["Player"]
  local bullet = pair["EnemyBullet"]
  local enemy = bullet:getParent()
  StatisticController.addToActions(bullet:get("Projectile").damage * enemy:get("Stats").damage, enemy:get("AI").actions)

  self:DamagePlayer(player, bullet:get("Projectile").damage * enemy:get("Stats").damage)
end

function CollisionSystem:PlayerAndEnemy(pair)
  local player = pair["Player"]
  local enemy = pair["Enemy"]

  local playerPos = player:get("Position")
  local playerRadius = player:get("Circle").radius

  local enemyPos = enemy:get("Position")
  local enemyRadius = player:get("Circle").radius
  local dist = (enemyRadius + playerRadius) - (playerPos:toVector() - enemyPos:toVector()):len()
  local dir = (playerPos:toVector() - enemyPos:toVector()):normalizeInplace()
  local step = dir * dist
  playerPos:setVector(playerPos:toVector() + step)

  self:checkStageBounds(playerPos, playerRadius)
end

function CollisionSystem:DamagePlayer(player, damage)
  invunerable = Utils.getChild(player, "Invunerable")
  if (invunerable:get("Timer").cooldown <= 0) then
    local hp = player:get("Hitpoints")
    hp.cur = hp.cur - damage
    if (hp.cur <= 0) then
      hp.cur = 0
      changeGameState("gameOver")
    else
      Utils.getChild(player, "Invunerable"):get("Timer"):start()
    end
  end
end

function CollisionSystem:killAndDrop(entity)
  local position = entity:get("Position")
  Utils.getEngine():addEntity(createHpDrop(position.x, position.y))
  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = entity
end

return CollisionSystem
