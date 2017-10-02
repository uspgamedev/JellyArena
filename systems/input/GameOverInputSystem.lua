local GameOverInputSystem = class("GameOverInputSystem", System)

function GameOverInputSystem:update(dt)
  if (love.keyboard.isDown("r")) then
    self.returnToGame()
  end
end

function GameOverInputSystem:returnToGame()
  for _, entity in pairs(engine.entities) do
    engine:removeEntity(entity, true)
  end

  engine:addEntity(createPlayer(getCenter().x, getCenter().y))

  changeGameState(GameStates.ingame)
end


function GameOverInputSystem:requires()
  return {}
end

return GameOverInputSystem
