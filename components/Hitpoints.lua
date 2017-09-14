local Hitpoints = Component.create("Hitpoints")

function Hitpoints:initialize(maxHp)
  self.cur = maxHp
  self.max = maxHp
end

function Hitpoints:add (num)
  self.cur = self.cur + num
  if (self.cur > self.max) then
    self.max = self.cur
  end
end
