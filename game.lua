Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "enemy"
  require "message"
  require "hud"
  self:reset()
end

function Game:reset()
  self.bullets = {}
  self.music = love.audio.newSource("test.ogg")
  self.message = Message()
  self.HUD = HUD()
  self.player = Player()
  self.enemies = {}
  self:spawnEnemies()
end

function Game:spawnEnemies()
  for i = 1, 5 do
    table.insert(self.enemies, Enemy(100+i*50, i*50))
  end
end

function Game:update(dt)
  if (self.player.hp == 0) then
    self.message.text = "Você morreu!\nContinuar? \n (Press y or n)"

    self.message.event = function()
      if love.keyboard.isDown("y") then
        self:reset()
      end
      if love.keyboard.isDown("n") then
        --TODO: go to start screen
      end
    end
    self.message:update()
  else
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
    self.music:setVolume(0.5)

    if(love.keyboard.isDown("escape")) then
      love.event.quit(0)
    end
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
  self.message:draw()
  self.HUD:draw(self)
end
