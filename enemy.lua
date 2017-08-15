Enemy = Object:extend()

function Enemy:new()
  self.x = 100
  self.y = 100
  self.radius = 20
  self.speed = 500
  self.color = {0, 255, 255}
end

function Enemy:update(game, dt)

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

function Enemy:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
