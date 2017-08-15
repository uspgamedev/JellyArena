Bullet = Object:extend()
function Bullet:new(x, y, speedX, speedY)
  self.x = x
  self.y = y
  self.speedX = speedX
  self.speedY = speedY
  self.radius = 5
  self.dead = false
end

function Bullet:update(game, dt)
  self.x = self.x + self.speedX * dt
  self.y = self.y + self.speedY * dt

  return self.dead
end

function Bullet:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
