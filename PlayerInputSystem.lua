local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, entity in pairs(self.targets) do
    self:movement(entity)
    self:fire(entity, dt)
  end
end

function PlayerInputSystem:requires()
  return {"Position", "Velocity", "Combat", "IsPlayer"}
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
  -- reset attack direction
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
    -- TODO: Create AttackProperties component with fireTimer and damage
    local position = entity:get("Position")
    engine:addEntity(Bullet(position.x, position.y, fireDirection, 10))

    fireTimer.cooldown = fireTimer.waitTime
  end
end

return PlayerInputSystem
