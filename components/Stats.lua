local Stats = Component.create("Stats")

function Stats:initialize(damage, movementSpeed, shotSpeed, bulletSpeed, shotRange)
  self.damage = damage
  self.movementSpeed = movementSpeed
  self.shotSpeed = shotSpeed
  self.bulletSpeed = bulletSpeed
  self.shotRange = shotRange
end

function Stats:getSpeed()
  return 150 + 20 * self.movementSpeed
end

function Stats:getShotRange()
  return 150 + 20 * self.shotRange
end

function Stats:getShotDelay()
  return 3.0 / self.shotSpeed
end

function Stats:getBulletSpeed()
  return 200 + 25 * self.bulletSpeed
end
