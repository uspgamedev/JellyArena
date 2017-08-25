local Enemy = class("Enemy", Entity)
local Position, Circle, IsEnemy, Velocity, Combat =
  Component.load({"Position", "Circle", "IsEnemy", "Velocity", "Combat"})

function Enemy:initialize(x, y)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 200))
  self:add(Combat(20, 0.1, "SimpleMelee", 5))
  self:add(IsEnemy("FollowPlayer"))
end

return Enemy
