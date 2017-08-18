Vector = require "hump.vector"
Enemy = Object:extend()

function Enemy:new(x, y)
  self.position = Vector(x,y)
  self.radius = 20
  self.speed = 100
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
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

function Enemy:followPlayer(game, dt)
  distance = self.speed*dt -- distance the enemy can walk
  direction = (self.position - game.player.position)
  maxDistance = direction:len() - self.radius - game.player.radius -- distance between enemy and player
  direction:normalizeInplace()

  if(distance > maxDistance) then
    distance = maxDistance
  end

  self.position = self.position - direction * distance
end

function Enemy:checkBulletCollision(game, dt)
  for _,b in pairs(game.bullets) do
    if(not b.dead) then
      if (b.position - self.position):len() < self.radius + b.radius then
        self:bulletHit(game, dt, b)
      end
    end
  end
end

function Enemy:bulletHit(game, dt, b)
  self:takeDamage(b.damage)
  self.position.x = self.position.x + (b.speed.x / 10)
  self.position.y = self.position.y + (b.speed.y / 10)
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
  window_height = love.graphics.getHeight() - self.radius

  if self.position.x < self.radius then
    self.position.x = self.radius
  elseif self.position.x > window_width then
    self.position.x = window_width
  end

  if self.position.y < self.radius then
    self.position.y = self.radius
  elseif self.position.y > window_height then
    self.position.y = window_height
  end
end
