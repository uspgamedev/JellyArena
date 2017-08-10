Player = Object:extend()
function Player:new()
  self.x = 0
  self.y = 0
  self.width = 30
  self.height = 30
  self.speed = 200
  self.actions = {
    w = function (dt) self.y = self.y - self.speed * dt end,
    s = function (dt) self.y = self.y + self.speed * dt end,
    a = function (dt) self.x = self.x - self.speed * dt end,
    d = function (dt) self.x = self.x + self.speed * dt end,
  }
end

function Player:update(dt)
  for key, action in pairs(self.actions) do
    if love.keyboard.isDown(key) then
      action(dt)
    end
  end
end

function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
