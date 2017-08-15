Game = Object:extend()

function Game:new()
  require "player"
  require "bullet"
  require "enemy"
  require "message"
  require "hud"
  self.player = Player()
  self.bullets = {}
  self.music = love.audio.newSource("test.ogg")
  self.message = Message()
  self.HUD = HUD()
  self.player = Player()
  self.bullets = {}
  self.enemy = Enemy()
end

function Game:update(dt)
  self.player:update(self, dt)

  if (self.player.hp == 0) then
    self.player.speed =  0
    self.player.bulletSpeed = 0
    self.message.text = "Você morreu!"
  end

  self.enemy:update(self, dt)
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
  self.enemy:draw()
  for _, b in ipairs(self.bullets) do
    b:draw()
  end
  self.message:draw()
  self.HUD:draw(self.player)
end
