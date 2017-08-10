Player = Object:extend()
function Player:new()
  self.x = 0
  self.y = 0
  self.radius = 15
  self.speed = 800
  self.actions = {
    w = function (dt) self.y = self.y - self.speed * dt end,
    s = function (dt) self.y = self.y + self.speed * dt end,
    a = function (dt) self.x = self.x - self.speed * dt end,
    d = function (dt) self.x = self.x + self.speed * dt end,
  }
end

function Player.fire()

end

function Player:update(dt)
  for key, action in pairs(self.actions) do
    if love.keyboard.isDown(key) then
      action(dt)
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
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
