local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, entity in pairs(self.targets) do
    -- if curGameState == "ingame" then
      self:movement(entity)
      self:fire(entity, dt)
      self:testTrack() --remove after track test
    -- end
  end
end

function PlayerInputSystem:requires()
  return {"IsPlayer"}
end

function PlayerInputSystem:movement(entity)
  local movementDir = Vector(0, 0)
  movementDir.x = (love.keyboard.isDown("d") and 1 or 0) - (love.keyboard.isDown("a") and 1 or 0)
  movementDir.y = (love.keyboard.isDown("s") and 1 or 0) - (love.keyboard.isDown("w") and 1 or 0)

  local velocity = entity:get("Velocity")
  velocity:setDirection(movementDir)
end

local fireDirections = {
  ["up"] = Vector(0, -1),
  ["down"] = Vector(0, 1),
  ["left"] = Vector(-1, 0),
  ["right"] = Vector(1, 0)
}
function PlayerInputSystem:fire(entity, dt)
  -- Reset attack direction
  local attack
  for _, child in pairs(entity.children) do
    if child:has("AttackProperties") then
      attack = child
    end
  end
  local fireDirection = Vector(0, 0)
  local fireTimer = attack:get("Timer");

  -- Continue only if we can shoot
  if fireTimer.isActive and fireTimer.cooldown > 0 then
    return
  end

  fireTimer.isActive = false

  -- Get fire direction
  -- Key preference is in reverse order of fireDirections
  for key, dir in pairs(fireDirections) do
    if love.keyboard.isDown(key) then
      fireDirection = dir
      fireTimer.isActive = true
    end
  end

  -- Fire a bullet
  if fireTimer.isActive then
    local hp = entity:get("Hitpoints")
    if hp.cur > 1 then
      local playerPosition = entity:get("Position")
      local position = playerPosition:toVector()
      local attackProperties = attack:get("AttackProperties")
      local range = attack:get("AttackRange")
      local attackDamage = attack:get("Damage").damage

      position = position + attackProperties.spawnDistance * fireDirection
      bullet = createPlayerBullet(position.x, position.y, fireDirection, attackDamage, range.max)
      getEngine():addEntity(bullet)
      hp.cur = hp.cur - 1;
      fireTimer.cooldown = fireTimer.waitTime
      playSound("teste")
    end
  end
end

--remove after track test
function PlayerInputSystem:testTrack()
  if love.keyboard.isDown("1") then
    setTrack("sample1")
  elseif love.keyboard.isDown("2") then
    setTrack("sample2")
  elseif love.keyboard.isDown("3") then
    setTrack("sample3")
  end
end

return PlayerInputSystem
