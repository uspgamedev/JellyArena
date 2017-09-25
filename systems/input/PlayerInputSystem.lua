local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, entity in pairs(self.targets) do
    self:movement(entity)
    self:fire(entity, dt)
  end
end

function PlayerInputSystem:requires()
  return {"Position", "Velocity", "AttackProperties", "Hitpoints", "IsPlayer"}
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
  local fireDirection = Vector(0, 0)
  local fireTimer = entity:get("Timer");

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
      local attack = entity:get("AttackProperties")

      position = position + attack.spawnDistance * fireDirection
      bullet = createBullet(position.x, position.y, fireDirection, attack.damage)
      engine:addEntity(bullet)
      hp.cur = hp.cur - 1;
      fireTimer.cooldown = fireTimer.waitTime
      playSound("teste")
    end
  end
end

return PlayerInputSystem
