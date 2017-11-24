local Color  = Component.create("Color")

function Color:initialize(r, g, b)
  self:set(r, g, b)
end

function Color:set(r, g, b)
  self.r = r
  self.g = g
  self.b = b
end
