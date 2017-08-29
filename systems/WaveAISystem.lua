local WaveAISystem = class("WaveAISystem", System)

function WaveAISystem:update(dt)
  if #self.targets == 0 then
    engine:addEntity(Enemy(100, 100))
    engine:addEntity(Enemy(200, 200))
    engine:addEntity(Enemy(300, 300))
  end
end

function WaveAISystem:requires()
  return {"IsEnemy"}
end

return WaveAISystem
