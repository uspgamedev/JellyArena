local Stats = Component.create("Stats")

function Stats:initialize(damage, movementSpeed, shotSpeed, bulletSpeed, shotRange)
  self.damage = damage
  self.movementSpeed = movementSpeed
  self.shotSpeed = shotSpeed
  self.bulletSpeed = bulletSpeed
  self.shotRange = shotRange
end
