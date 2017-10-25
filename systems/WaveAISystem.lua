local WaveAISystem = class("WaveAISystem", System)

function WaveAISystem:update(dt)
  local count = 0
  for _,p in pairs(self.targets) do
    count = count + 1
  end
  if count == 0 then
    getEngine():addEntity(createEnemy(10, 10))
    getEngine():addEntity(createEnemy(10, 10000))
    getEngine():addEntity(createEnemy(10000, 10))
    getEngine():addEntity(createEnemy(10000, 100000))
  end
end

function WaveAISystem:requires()
  return {"IsEnemy"}
end

return WaveAISystem
