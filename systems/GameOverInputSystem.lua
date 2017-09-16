local GameOverInputSystem = class("GameOverInputSystem", System)

function GameOverInputSystem:update(dt)
  if (love.keyboard.isDown("r")) then
    debug_text = ""
    for _, entity in pairs(engine.entities) do
      engine:removeEntity(entity, true)
    end

    engine:addEntity(createPlayer(getCenter().x, getCenter().y))
    engine:addEntity(createMessage())

    changeGameState(GameStates.ingame)
  end
end

function GameOverInputSystem:requires()
  return {}
end

return GameOverInputSystem
