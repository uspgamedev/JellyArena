local NewGameSystem = class("NewGameSystem", System)

function NewGameSystem:initialize()
  System.initialize(self)
end

function NewGameSystem:update(dt)
  gameOver = true
  for i, player in pairs(self.targets) do
    if(player:get("Hitpoints").cur > 0) then
      gameOver = false
    end
  end

  if gameOver then
    debug_text = "Você morreu! Deseja voltar do início?"
    if (yes) then
      debug_text = ""
      for _, entity in pairs(engine.entities) do
        engine:removeEntity(entity, true)
      end

      engine:addEntity(createPlayer(getCenter().x, getCenter().y))
      engine:addEntity(createMessage())
    end
  end
end

function NewGameSystem:requires()
  return { "IsPlayer" }
end

return NewGameSystem
