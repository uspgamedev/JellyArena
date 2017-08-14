Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "message"
  self.player = Player()
  self.bullets = {}
  self.music = love.audio.newSource("test.ogg")
  self.message = Message()
end

function Game:update(dt)
  self.player:update(self, dt)
  if (self.player.hp == 0) then
    self.message.text = "Você morreu! huehuehue"
  end
  for i, b in ipairs(self.bullets) do
    if(b:update(self, dt)) then
      table.remove(self.bullets, i)
    end
  end
  self.music:setVolume(0.5)
  --love.audio.play(self.music)
end

function Game:draw()
  self.player:draw()
  for _, b in ipairs(self.bullets) do
    b:draw()
  end
  self.message:draw()
end
