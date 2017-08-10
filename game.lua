Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  self.player = Player()
  self.bullets = {}
end

function Game:update(dt)
  self.player:update(self, dt)
  for i, b in ipairs(self.bullets) do
    if(b:update(self, dt)) then
      table.remove(self.bullets, i)
    end
  end
end

function Game:draw()
  self.player:draw()
  for _, b in ipairs(self.bullets) do
    b:draw()
  end
end
