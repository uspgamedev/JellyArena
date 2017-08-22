Bullet = Object:extend()
function Bullet:new(x, y, speedX, speedY, damage)
  self.position = Vector(x,y)
  self.damage = damage
  self.speed = Vector(speedX,speedY)
  self.radius = 5
  self.dead = false
end

function Bullet:update(game, dt)
  self.position = self.position + self.speed * dt

  return self.dead
end

function Bullet:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end
