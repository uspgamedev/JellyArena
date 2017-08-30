local Projectile  = Component.create("Projectile")

function Projectile:initialize(damage, maxDistance)
  self.damage = damage
  self.maxDistance = maxDistance
end
