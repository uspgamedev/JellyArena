local Enemy = class("Enemy", Entity)
local Position, Circle, IsEnemy, Velocity, Color =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Color"})

function Enemy:initialize(x, y)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 200))
  self:add(IsEnemy("FollowPlayer"))
  self:add(Color(0, 255, 255))
end

return Enemy
