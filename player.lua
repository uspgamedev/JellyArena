Player = Object:extend()

function Player:new()
  self.position = Vector(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
  self.velocity = Vector(0, 0)
  self.speed = 500
  self.radius = 20
  self.fireDelay = 0.5
  self.cooldown = 0
  self.maxHp = 20
  self.hp = self.maxHp
end
