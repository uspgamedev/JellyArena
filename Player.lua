local Player = class("Player", Entity)
local Position, Circle, IsPlayer, Velocity, Combat, Timer =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "Combat", "Timer"})

function Player:initialize(x, y)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 500))
  self:add(Combat(20, 0.3, "PlayerSimpleBullet", 5))
  self:add(Timer(0.3))
  self:add(IsPlayer())
end

return Player
