local Hitpoints = Component.create("Hitpoints")

function Hitpoints:initialize(maxHp)
  self.cur = maxHp
  self.max = maxHp
end