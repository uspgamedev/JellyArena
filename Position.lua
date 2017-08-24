local Position  = Component.create("Position")

function Position:initialize(x, y)
  self.x = x
  self.y = y
end

function Position:toVector()
  return Vector(self.x, self.y)
end

function Position:setVector(vector)
  self.x = vector.x
  self.y = vector.y
end
