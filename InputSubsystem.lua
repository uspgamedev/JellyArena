local Vector = require "hump.vector"
InputSubsystem = Object:extend()

function InputSubsystem:new()
end

function InputSubsystem:update(game, dt)
  player = game.player

  -- Change player velocity
  player.velocity = Vector(0, 0)
  
  local movementDir = Vector(0, 0)
  movementDir.x = (love.keyboard.isDown("d") and 1 or 0) - (love.keyboard.isDown("a") and 1 or 0)
  movementDir.y = (love.keyboard.isDown("s") and 1 or 0) - (love.keyboard.isDown("w") and 1 or 0)
  movementDir:normalizeInplace()
  
  player.velocity.x = movementDir.x * player.speed
  player.velocity.y = movementDir.y * player.speed

  -- TODO: Fire
end