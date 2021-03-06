local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, entity in pairs(self.targets) do
    -- if curGameState == "ingame" then
    self:movement(entity)
    self:fire(entity, dt)
    self:melee(entity, dt)
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

  local animation = entity:get("Animation")
  if(movementDir == Vector(0, 0)) then
    animation:changeFrameTime(0.4)
  else
    animation:changeFrameTime(0.1)
  end

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
  local fireTimer = attack:get("Timer")

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
      local stats = entity:get("Stats")
      local attackDamage = attack:get("Damage").damage * stats.damage
      local bulletSpeed = stats:getBulletSpeed()
      position = position + attackProperties.spawnDistance * fireDirection
      bullet = createPlayerBullet(position.x, position.y, fireDirection, attackDamage, range.max, bulletSpeed)
      Utils.getEngine():addEntity(bullet)
      hp.cur = hp.cur - 1
      fireTimer.cooldown = fireTimer.waitTime
      SoundController.playSound("shot")
    end
  end
end

function PlayerInputSystem:melee(entity, dt)
  local meleeTimer = entity:get("Timer")
  if meleeTimer.isActive and meleeTimer.cooldown > 0 then
    return
  end

  meleeTimer.isActive = false

  if love.keyboard.isDown("space") then
    meleeTimer.isActive = true
    local position = entity:get("Position")
    local damage = 4 * entity:get("Stats").damage
    local damageArea = createDamageArea(position, 100, damage, entity)
    Utils.getEngine():addEntity(damageArea)
    table.insert(garbageList, damageArea)
    meleeTimer.cooldown = meleeTimer.waitTime
    SoundController.playSound("melee")
  end
end

--remove after track test
function PlayerInputSystem:testTrack()
  if love.keyboard.isDown("1") then
    SoundController.setTrack("menu")
  elseif love.keyboard.isDown("2") then
    SoundController.setTrack("waves")
  elseif love.keyboard.isDown("3") then
    SoundController.setTrack("boss")
  end
end

return PlayerInputSystem
