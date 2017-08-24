local Player = class("Player", Entity)
local Position, Circle, IsPlayer, Velocity = Component.load({"Position", "Circle", "IsPlayer", "Velocity"})

function Player:initialize()
  Entity.initialize(self)
  self:add(Position(100, 100))
  self:add(Circle(20))
  self:add(Velocity(0, 0, 500))
  self:add(IsPlayer())
end

return Player
