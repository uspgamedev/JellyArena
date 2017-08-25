local Player = class("Player", Entity)
local Position, Circle, IsPlayer, Velocity, Combat =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "Combat"})

function Player:initialize()
  Entity.initialize(self)
  self:add(Position(100, 100))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 500))
  self:add(Combat(20, 0.1, "PlayerSimpleBullet", 5))
  self:add(IsPlayer())
end

return Player
