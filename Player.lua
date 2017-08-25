local Player = class("Player", Entity)
local Position, Circle, IsPlayer, Velocity, Combat =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "Combat"})

function Player:initialize(x, y)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 500))
  self:add(Combat(20, 0.1, "SimpleBullet", 5))
  self:add(IsPlayer())
end

return Player
