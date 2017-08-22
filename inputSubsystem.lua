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

  -- Fire
  fireDirections = {
    ["up"] = Vector(0, -1),
    ["down"] = Vector(0, 1),
    ["left"] = Vector(-1, 0),
    ["right"] = Vector(1, 0)
  }

  player.cooldown = player.cooldown - dt
  for key, dir in pairs(fireDirections) do
    if player.cooldown <= 0 then
      if love.keyboard.isDown(key) then
        player.cooldown = player.fireDelay
        table.insert(game.movableEntities, Bullet(player.position, dir))
      end
    end
  end
end
