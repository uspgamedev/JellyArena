Enemy = Object:extend()

function Enemy:new(x, y)
  self.x = x or 100
  self.y = y or 100
  self.radius = 20
  self.speed = 10
  self.hp = 5
  self.color = {0, 255, 255}
  self.dead = false
end

function Enemy:update(game, dt)
  self:followPlayer(game, dt)
  self:checkBulletCollision(game, dt)
  self:checkWindowLimit(game, dt)
  return self.dead
end

function Enemy:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Enemy:followPlayer(game, dt)
  step = self.speed * dt
  if step > math.abs(self.x - game.player.x) then
    step = math.abs(self.x - game.player.x)
  end
  if self.x > game.player.x then
    self.x = self.x - step
  else
    self.x = self.x + step
  end

  step = self.speed * dt
  if step > math.abs(self.y - game.player.y) then
    step = math.abs(self.y - game.player.y)
  end
  if self.y > game.player.y then
    self.y = self.y - step
  else
    self.y = self.y + step
  end
end

function Enemy:checkBulletCollision(game, dt)
  for _,b in pairs(game.bullets) do
    if(not b.dead) then
      dist = self.radius + b.radius
      dist = dist * dist
      deltaX = (self.x - b.x) * (self.x - b.x)
      deltaY = (self.y - b.y) * (self.y - b.y)
      if dist > deltaY + deltaX then
        self:bulletHit(game, dt, b)
      end

    end
  end
end

function Enemy:bulletHit(game, dt, b)
  self:takeDamage(b.damage)
  self.x = self.x + (b.speedX / 10)
  self.y = self.y + (b.speedY / 10)
  b.dead = true
end

function Enemy:takeDamage(damage)
  self.hp = self.hp - damage
  if(self.hp <= 0) then
    self.dead = true
  end
end

function Enemy:checkWindowLimit(game, dt)
  window_width = love.graphics.getWidth() - self.radius
  if self.x < self.radius then
    self.x = self.radius
  elseif self.x > window_width then
    self.x = window_width
  end

  window_height = love.graphics.getHeight() - self.radius
  if self.y < self.radius then
    self.y = self.radius
  elseif self.y > window_height then
    self.y = window_height
  end
end
