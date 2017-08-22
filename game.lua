Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "inputSubsystem"
  require "movementSubsystem"

  self.player = Player()
  self.input = InputSubsystem()
  self.movement = MovementSubsystem()
  self.movableEntities = {self.player}
end

function Game:update(dt)
  self.input:update(self, dt)
  self.movement:update(self, dt)
end

function Game:draw()
  for _,e in ipairs(self.movableEntities) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", e.position.x, e.position.y, e.radius)
  end
end
