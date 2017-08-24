local Player = class("Player", Entity)
local Position, Circle = Component.load({"Position", "Circle"})

function Player:initialize()
  Entity.initialize(self)
  self:add(Position(100, 100))
  self:add(Circle(20))
end

return Player
