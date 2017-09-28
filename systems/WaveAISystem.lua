local WaveAISystem = class("WaveAISystem", System)

function WaveAISystem:update(dt)
  local count = 0
  for _,p in pairs(self.targets) do
    count = count + 1
  end
  if count == 0 then
    local enemy = createEnemy(10, 10)
    engine:addEntity(enemy)
    engine:addEntity(createMeleeAttack(enemy))
    enemy = createEnemy(10, 1000000)
    engine:addEntity(enemy)
    engine:addEntity(createMeleeAttack(enemy))
    enemy = createEnemy(1000000, 10)
    engine:addEntity(enemy)
    engine:addEntity(createMeleeAttack(enemy))
    enemy = createEnemy(1000000, 1000000)
    engine:addEntity(enemy)
    engine:addEntity(createMeleeAttack(enemy))
  end
end

function WaveAISystem:requires()
  return {"AI"}
end

return WaveAISystem
