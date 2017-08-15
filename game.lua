Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "enemy"
  self.player = Player()
  self.bullets = {}
  self.enemies = {}
  self:spawnEnemies()
end

function Game:spawnEnemies()
  for i = 1, 50 do
    table.insert(self.enemies, Enemy(i*50, i*50))
  end
end

function Game:update(dt)
  self.player:update(self, dt)

  for i, e in ipairs(self.enemies) do
    if(e:update(self, dt)) then
      table.remove(self.enemies, i)
    end
  end
  if(#self.enemies == 0) then
    self:spawnEnemies()
  end


  for i, b in ipairs(self.bullets) do
    if(b:update(self, dt)) then
      table.remove(self.bullets, i)
    end
  end

  if(love.keyboard.isDown("escape")) then
    love.event.quit(0)
  end
end

function Game:draw()
  self.player:draw()

  for i, e in ipairs(self.enemies) do
    e:draw()
  end

  for _, b in ipairs(self.bullets) do
    b:draw()
  end
end
