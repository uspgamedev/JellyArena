local AttackProperties = Component.create("AttackProperties")

function AttackProperties:initialize(damage, range, spawnDistance)
  self.damage = damage
  self.range = range
  self.spawnDistance = spawnDistance
end
