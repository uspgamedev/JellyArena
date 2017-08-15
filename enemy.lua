Enemy = Object:extend()

function Enemy:new()
  self.x = 100
  self.y = 100
  self.radius = 20
  self.speed = 500
  self.color = {0, 255, 255}
end

function Enemy:update(game, dt)

end

function Enemy:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
