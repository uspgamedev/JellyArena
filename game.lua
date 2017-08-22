Game = Object:extend()

function Game:new()
  require "player"
  require "inputSubsystem"
  require "movementSubsystem"

  self.player = Player()
  self.input = InputSubsystem()
  self.movement = MovementSubsystem()
  self.movableEntities = {}
  table.insert(self.movableEntities, self.player)
end

function Game:update(dt)
  self.input:update(self, dt)
  self.movement:update(self, dt)
end

function Game:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", self.player.position.x, self.player.position.y, self.player.radius)
end
