Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "enemy"
  self.player = Player()
  self.bullets = {}
  self.enemy = Enemy()
end

function Game:update(dt)
  self.player:update(self, dt)
  self.enemy:update(self, dt)
  for i, b in ipairs(self.bullets) do
    if(b:update(self, dt)) then
      table.remove(self.bullets, i)
    end
  end
end

function Game:draw()
  self.player:draw()
  self.enemy:draw()
  for _, b in ipairs(self.bullets) do
    b:draw()
  end
end
