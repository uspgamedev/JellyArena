local PlayerInputSystem = class("PlayerInputSystem", System)

function PlayerInputSystem:update(dt)
  for i, v in pairs(self.targets) do
    local movementDir = Vector(0, 0)
    movementDir.x = (love.keyboard.isDown("d") and 1 or 0) - (love.keyboard.isDown("a") and 1 or 0)
    movementDir.y = (love.keyboard.isDown("s") and 1 or 0) - (love.keyboard.isDown("w") and 1 or 0)

    local velocity = v:get("Velocity")
    velocity:setDirection(movementDir)
  end
end

function PlayerInputSystem:requires()
  return {"Position", "Velocity", "IsPlayer"}
end

return PlayerInputSystem
