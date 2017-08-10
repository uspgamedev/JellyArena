function love.load()
  Object = require "classic"
  require "game"

  game = Game()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end
