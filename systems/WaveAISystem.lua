local WaveAISystem = class("WaveAISystem", System)

function WaveAISystem:update(dt)
  count = 0
  for _,p in pairs(self.targets) do
    count = count + 1
  end
  if count == 0 then
    engine:addEntity(createEnemy(100, 100))
    engine:addEntity(createEnemy(200, 200))
    engine:addEntity(createEnemy(300, 300))
  end
end

function WaveAISystem:requires()
  return {"IsEnemy"}
end

return WaveAISystem
