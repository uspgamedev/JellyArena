local AttackRange  = Component.create("AttackRange")

function AttackRange:initialize(max, min)
  self.max = max
  self.min = min or -1
end
