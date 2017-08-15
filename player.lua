Player = Object:extend()
function Player:new()
  self.maxHp = 200
  self.movementSpeed = 1
  self.attackSpeed = 5
  self.hp = self.maxHp
  self.x = 0
  self.y = 0
  self.radius = 20
  self.speed = 200 + self.movementSpeed * 20
  self.bulletSpeed = 200 + self.attackSpeed * 50

  self.speed = 800
  self.bulletSpeed = 1000
  self.fireDelay = 0.2
  self.cooldown = 0
  self.actions = {
    w = function (game, dt) self.y = self.y - self.speed * dt end,
    s = function (game, dt) self.y = self.y + self.speed * dt end,
    a = function (game, dt) self.x = self.x - self.speed * dt end,
    d = function (game, dt) self.x = self.x + self.speed * dt end,
    ["up"] = function (game, dt) self:fire(game, 0, -1) end,
    ["down"] = function (game, dt) self:fire(game, 0, 1) end,
    ["left"] = function (game, dt) self:fire(game, -1, 0) end,
    ["right"] = function (game, dt) self:fire(game, 1, 0) end,
  }
end

function Player:fire(game, x, y)
  if self.cooldown <= 0 and self.hp > 0 then
    self.cooldown = self.fireDelay
    bullet = Bullet(self.x + x * 30, self.y + y * 30, self.bulletSpeed * x, self.bulletSpeed * y, 1)
    table.insert(game.bullets, bullet)
    self.hp = self.hp - 1

  end
end

function Player:update(game, dt)
  self.cooldown = self.cooldown - dt
  for key, action in pairs(self.actions) do
    if love.keyboard.isDown(key) then
      action(game, dt)
    end
  end

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

function Player:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
