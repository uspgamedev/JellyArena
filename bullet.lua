Bullet = Object:extend()
function Bullet:new(position, direction)
  self.position = position
  self.speed = 600
  self.velocity = direction * 600
  self.radius = 5
end
