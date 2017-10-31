local TrapSpawnSystem = class("TrapSpawnSystem", System)

function TrapSpawnSystem:update(dt)
  local count = 0
  for _,p in pairs(self.targets) do
    count = count + 1
  end

  if count == 0 then

    for i = 1, 2, 1 do
      trapTest = createDamageTrap(math.random(0, love.graphics.getWidth() - 100), math.random(0, love.graphics.getHeight() - 100))
      Utils.getEngine():addEntity(trapTest)
    end

    for i = 1, 2, 1 do
      trapTest = createHealingTrap(math.random(0, love.graphics.getWidth() - 100), math.random(0, love.graphics.getHeight() - 100))
      Utils.getEngine():addEntity(trapTest)
    end

    for i = 1, 5, 1 do
      trapTest = createPushTrap(math.random(0, love.graphics.getWidth() - 100), math.random(0, love.graphics.getHeight() - 100))
      Utils.getEngine():addEntity(trapTest)
    end
  end
end

function TrapSpawnSystem:requires()
  return {"Label", "Position", "Circle", "Color", "Collider", "Visibility"}
end

return TrapSpawnSystem
