local Projectile  = Component.create("Projectile")

function Projectile:initialize(owner, damage, maxDistance)
  self.owner = owner
  self.damage = damage
  self.maxDistance = maxDistance
  self.displacement = 0
end

function Projectile:addDisplacement(displacement)
  self.displacement = self.displacement + displacement
end

function Projectile:moving()
  if (self.displacement < self.maxDistance) then
    return true
  end
  return false
end
