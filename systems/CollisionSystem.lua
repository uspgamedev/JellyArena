local CollisionSystem = class("CollisionSystem", System)

function CollisionSystem:initialize()
  System.initialize(self)

  self.collisionPairs = {}
  self.collisionPairsCount = 0

  self:reset()
end

function CollisionSystem:reset()
  self.ignore = {}
end

function CollisionSystem:update(dt)
  -- Check screen bounds, reposition or remove entities
  for i, v in pairs(self.targets) do
    local collider = v:get("Collider")
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    -- Delete entities that have gone outside stage bounds
    if (collider.clampToStageBounds) then
      self:checkStageBounds(position, radius)
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

            if (dist < minDist and not self:checkIgnored(v, w)) then
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
      elseif (pair["Enemy"] and pair["DamageArea"]) then
        self:EnemyAndDamageArea(pair)
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
end

function CollisionSystem:requires()
  return {"Collider"}
end

function CollisionSystem:checkStageBounds(position, radius)
  local mapSize = Utils.mapDefinitions
  local size = {["x"] = mapSize.width - radius, ["y"] = mapSize.height - radius}
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

function CollisionSystem:checkIgnored(collider1, collider2)
  if(self.ignore[collider1]) then
    return self.ignore[collider1][collider2] == true
  end

  if(self.ignore[collider2]) then
    return self.ignore[collider2][collider1] == true
  end

  return false
end

function CollisionSystem:markIgnored(collider1, collider2)
  if self.ignore[collider1] == nil then
      self.ignore[collider1] = {}
  end
  self.ignore[collider1][collider2] = true
end

function CollisionSystem:PlayerAndHpDrop(pair)
  local player = pair["Player"]
  local drop = pair["HpDrop"]
  local hp = player:get("Hitpoints")

  hp:add(1)
  Utils.addGarbage(drop)
end

function CollisionSystem:PlayerAndTrap(pair)
  local player = pair["Player"]
  local trap = pair["Trap"]
  local trapType = trap:get("Label").label

  if (trapType == "DamageTrap") then
    local damage = trap:get("Damage").damage
    StatisticController.addToActions(damage, trap:getParent():get("AI").actions)
    self:DamagePlayer(player, damage)
  elseif (trapType == "HealingTrap") then
    player:get("Hitpoints"):add(10)
  else
    math.randomseed(os.time())
    self:PushPlayer(player, math.random(4), 200)
  end
  Utils.addGarbage(trap)
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
  SoundController.playSound("hit")
  if (enemyHp.cur - bulletDamage > 0) then
    enemyHp.cur = enemyHp.cur - bulletDamage
  else
    self:killAndDrop(enemy)
  end
  self:markIgnored(bullet, enemy)
end

function CollisionSystem:EnemyAndDamageArea(pair)
  local enemy = pair["Enemy"]
  local enemyHp = enemy:get("Hitpoints")
  local damageArea = pair["DamageArea"]
  local parent = damageArea:getParent()
  local damage = damageArea:get("Damage").damage
  if (parent:get("IsPlayer")) then
    if (enemyHp.cur - damage > 0) then
      enemyHp.cur = enemyHp.cur - damage
    else
      self:killAndDrop(enemy)
    end
  end
  self:markIgnored(enemy, damageArea)
end

function CollisionSystem:PlayerAndDamageArea(pair)
  local player = pair["Player"]
  local damage = pair["DamageArea"]
  local parent = damage:getParent()
  if (parent ~= player) then
    StatisticController.addToActions(damage:get("Damage").damage, parent:get("AI").actions)

    self:DamagePlayer(player, damage:get("Damage").damage)
  end
  self:markIgnored(player, damage)
end

function CollisionSystem:PlayerAndEnemyBullet(pair)
  local player = pair["Player"]
  local bullet = pair["EnemyBullet"]
  local enemy = bullet:getParent()
  StatisticController.addToActions(bullet:get("Projectile").damage, enemy:get("AI").actions)

  self:DamagePlayer(player, bullet:get("Projectile").damage)
  self:markIgnored(player, bullet)
end

function CollisionSystem:PlayerAndEnemy(pair)
  local player = pair["Player"]
  local enemy = pair["Enemy"]

  local playerPos = player:get("Position")
  local playerRadius = player:get("Circle").radius

  local enemyPos = enemy:get("Position")
  local enemyRadius = enemy:get("Circle").radius
  local dist = (enemyRadius + playerRadius) - (playerPos:toVector() - enemyPos:toVector()):len()
  local dir = (playerPos:toVector() - enemyPos:toVector()):normalizeInplace()
  local step = dir * dist
  playerPos:setVector(playerPos:toVector() + step)

  self:checkStageBounds(playerPos, playerRadius)
end

function CollisionSystem:DamagePlayer(player, damage)
  invunerable = Utils.getChild(player, "Invunerable")
  if (invunerable:get("Timer").cooldown <= 0 or true) then
    local hp = player:get("Hitpoints")
    hp.cur = hp.cur - damage
    if (hp.cur <= 0) then
      hp.cur = 0
      GameState.changeGameState("gameOver")
    else
      Utils.getChild(player, "Invunerable"):get("Timer"):start()
    end
  end
end

function CollisionSystem:killAndDrop(entity)
  local position = entity:get("Position")
  Utils.getEngine():addEntity(createHpDrop(position.x, position.y))
  Utils.addGarbage(entity)
end

return CollisionSystem
