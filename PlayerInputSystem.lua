local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, entity in pairs(self.targets) do
    self:movement(entity)
    self:fire(entity)
  end
end

function PlayerInputSystem:requires()
  return {"Position", "Velocity", "IsPlayer"}
end

function PlayerInputSystem:movement(entity)
  local movementDir = Vector(0, 0)
  movementDir.x = (love.keyboard.isDown("d") and 1 or 0) - (love.keyboard.isDown("a") and 1 or 0)
  movementDir.y = (love.keyboard.isDown("s") and 1 or 0) - (love.keyboard.isDown("w") and 1 or 0)

  local velocity = entity:get("Velocity")
  velocity:setDirection(movementDir)
end

function PlayerInputSystem:fire(entity)
  fireDirections = {
    ["up"] = Vector(0, -1),
    ["down"] = Vector(0, 1),
    ["left"] = Vector(-1, 0),
    ["right"] = Vector(1, 0)
  }

  for key, dir in pairs(fireDirections) do
    if love.keyboard.isDown(key) then
      local position = entity:get("Position")
      engine:addEntity(Bullet(position.x, position.y, dir))
    end
  end
end

return PlayerInputSystem
