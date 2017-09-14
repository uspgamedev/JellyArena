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
    if (self:checkWindowLimit(position, radius) and not collider.clampToStageBounds) then
      collider.active = false
      self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
      self.entitiesToRemove[self.entitiesToRemoveCount] = v
    end
  end

  -- Generate collision pairs
  for i, v in pairs(self.targets) do
    local vCollider = v:get("Collider")

    if(vCollider.active) then
      local vPos = v:get("Position"):toVector()
      local vRad = v:get("Circle").radius

      for j, w in pairs(self.targets) do
        if (j > i) then
          local wCollider = w:get("Collider")

          if(wCollider.active) then
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
      elseif (pair["Enemy"] and pair["Bullet"]) then
        self:BulletAndEnemy(pair)
      elseif (pair["Player"] and pair["Enemy"]) then
        self:PlayerAndEnemy(pair)
      end
    end

    -- lovetoys.debug("BATEU: "..v.id..":"..w.id)
    -- debug_text = "BATEU: "..v.id..":"..w.id
  end

  -- Clean collisionPairs array
  for i = 1, self.collisionPairsCount, 1 do
    local pair = self.collisionPairs[i]
    for _,entity in pairs(pair) do
      entity:get("Collider").resolved = false
    end
    self.collisionPairs[i] = nil
  end
  self.collisionPairsCount = 0

  -- Remove flagged entities
  for i = 1, self.entitiesToRemoveCount, 1 do
    engine:removeEntity(self.entitiesToRemove[i], true)
    self.entitiesToRemove[i] = nil
  end
  self.entitiesToRemoveCount = 0
end

function CollisionSystem:requires()
  return { "Collider" }
end

function CollisionSystem:checkWindowLimit(position, radius)
  -- TODO: change to stage bounds instead of window bounds
  window_width = love.graphics.getWidth() - radius
  window_height = love.graphics.getHeight() - radius
  check = false
  if position.x < radius then
    check = true
    position.x = radius
  elseif position.x > window_width then
    check = true
    position.x = window_width
  end

  if position.y < radius then
    check = true
    position.y = radius
  elseif position.y > window_height then
    check = true
    position.y = window_height
  end

  return check
end

function CollisionSystem:PlayerAndHpDrop(pair)
  player = pair["Player"]
  drop = pair["HpDrop"]
  hp = player:get("Hitpoints")
  hp:add(1)
  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = drop
end

function CollisionSystem:BulletAndEnemy(pair)
  bullet = pair["Bullet"]
  enemy = pair["Enemy"]
  self:killAndDrop(bullet)
  bullet:get("Collider").resolved = true
  self:killAndDrop(enemy)
end

function CollisionSystem:PlayerAndEnemy(pair)
  player = pair["Player"]
  enemy = pair["Enemy"]
  timer = enemy:get("Timer")
  if (timer.cooldown > 0) then
    return
  end
  hp = player:get("Hitpoints")
  hp.cur = hp.cur - 1
  timer:start()

end

function CollisionSystem:killAndDrop (entity)
  position = entity:get("Position")
  engine:addEntity(createHpDrop(position.x, position.y))
  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = entity
end

return CollisionSystem
