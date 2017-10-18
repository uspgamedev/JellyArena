local TrapSpawnSystem = class("TrapSpawnSystem", System)

function TrapSpawnSystem:update(dt)
  if trapTest1 == nil then
    trapTest1 = createDamageTrap(20, 100)
    engine:addEntity(trapTest1)
  end

  if trapTest2 == nil then
    trapTest2 = createPushTrap(200, 300)
    engine:addEntity(trapTest2)
  end

  if trapTest3 == nil then
    trapTest3 = createHealingTrap(500, 100)
    engine:addEntity(trapTest3)
  end
end

function TrapSpawnSystem:requires()
  return {"Label", "Position", "Circle", "Color", "Collider", "Visibility"}
end

return TrapSpawnSystem
