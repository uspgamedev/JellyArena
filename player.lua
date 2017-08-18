Vector = require "hump.vector"
Player = Object:extend()

function Player:new()
  self.maxHp = 1000
  self.hp = self.maxHp
  self.position = Vector(0, 0)
  self.radius = 20
  self.speed = 200
  self.bulletDamage = 5
  self.bulletSpeed = 1000
  self.fireDelay = 0.2
  self.cooldown = 0

  self.movementDirections = {
    w = Vector(0, -1),
    s = Vector(0, 1),
    a = Vector(-1, 0),
    d = Vector(1, 0)
  }

  self.fireDirections = {
    ["up"] = Vector(0, -1),
    ["down"] = Vector(0, 1),
    ["left"] = Vector(-1, 0),
    ["right"] = Vector(1, 0)
  }
end

function Player:move(game, dt, direction)
  self.position = self.position + self.speed * direction * dt
  self:checkWindowLimit(game, dt)
end

function Player:checkWindowLimit(game, dt)
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

function Player:fire(game, direction)
  if self.cooldown <= 0 and self.hp > 0 then
    self.cooldown = self.fireDelay
    bullet = Bullet(
      self.position.x + direction.x * self.radius,
      self.position.y + direction.y * self.radius,
      self.bulletSpeed * direction.x,
      self.bulletSpeed * direction.y,
      self.bulletDamage)
    table.insert(game.bullets, bullet)
    self.hp = self.hp - 1
  end
end

function Player:dead()
  return self.hp == 0;
end

function Player:update(game, dt)
  movementDirection = Vector(0,0)
  for key, dir in pairs(self.movementDirections) do
    if love.keyboard.isDown(key) then
      movementDirection = movementDirection + dir
    end
  end
  self:move(game, dt, movementDirection)

  self.cooldown = self.cooldown - dt
  for key, dir in pairs(self.fireDirections) do
    if love.keyboard.isDown(key) then
      self:fire(game, dir)
    end
  end
end

function Player:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end
