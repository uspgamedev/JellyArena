local AttackProperties = Component.create("AttackProperties")

function AttackProperties:initialize(damage, spawnDistance)
  self.damage = damage
  self.spawnDistance = spawnDistance
end