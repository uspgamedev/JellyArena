Player = Object:extend()
function Player:new()
  self.x = 0
  self.y = 0
  self.radius = 20
  self.speed = 800
  self.bulletSpeed = 1000
  self.maxHp = 200
  self.hp = self.maxHp
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
  bullet = Bullet(self.x + x * 30, self.y + y * 30, self.bulletSpeed * x, self.bulletSpeed * y)
  table.insert(game.bullets, bullet)

  if self.hp > 0 then
    self.hp = self.hp - 1
  end
end

function Player:update(game, dt)
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

  love.graphics.rectangle("line", 10, 10, 200, 20)
  love.graphics.setNewFont(16)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 11, 11, 198*(self.hp/self.maxHp), 18)
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf( self.hp.."/"..self.maxHp, 20, 12, 200, "center")
end
