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
              self.collisionPairs[self.collisionPairsCount] = {v, w}
            end
          end
        end
      end
    end
  end

  -- Resolve collision pairs
  for _,pair in pairs(self.collisionPairs) do
      -- TODO: handle each pair type

      local v = pair[1]
      local w = pair[2]

      vType = v:get("Collider").type
      wType = w:get("Collider").type

      if (vType == "Player" and wType == "HpDrop") then
        self:PlayerAndHpDrop(v, w)
      elseif (vtype == "HpDrop" and wType == "Player") then
        self:PlayerAndHpDrop(w, v)
      end

      lovetoys.debug("BATEU: "..v.id..":"..w.id)
      debug_text = "BATEU: "..v.id..":"..w.id
  end

  -- Clean collisionPairs array
  for i = 1, self.collisionPairsCount, 1 do
    local pair = self.collisionPairs[i]

    pair[1].resolved = false
    pair[2].resolved = false

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

function CollisionSystem:PlayerAndHpDrop(player, drop)
  hp = player:get("Hitpoints")
  hp:add(1)
  self.entitiesToRemoveCount = self.entitiesToRemoveCount + 1
  self.entitiesToRemove[self.entitiesToRemoveCount] = drop
end

return CollisionSystem
