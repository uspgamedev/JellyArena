Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "inputSubsystem"
  require "movementSubsystem"
  require "drawSubsystem"

  self.player = Player()
  self.input = InputSubsystem()
  self.drawSubsystem = DrawSubsystem()
  self.movement = MovementSubsystem()
  self.movableEntities = {self.player}
  self.drawableEntities = {self.player}
end

function Game:update(dt)
  self.input:update(self, dt)
  self.movement:update(self, dt)
end

function Game:draw()
  self.drawSubsystem:draw(self)
end
