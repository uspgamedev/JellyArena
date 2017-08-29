local Player = class("Player", Entity)
local Position, Circle, IsPlayer, Velocity, AttackProperties, Timer, HP, Color =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "AttackProperties", "Timer", "Hitpoints", "Color"})

function Player:initialize(x, y)
  Entity.initialize(self)
  self:add(Position(x, y))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 500))
  self:add(AttackProperties(5, 25))
  self:add(HP(20))
  self:add(Timer(0.3))
  self:add(IsPlayer())
  self:add(Color(255, 255, 255))
end

return Player
