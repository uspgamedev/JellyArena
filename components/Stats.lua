local Stats = Component.create("Stats")

function Stats:initialize(damage, movementSpeed, shotSpeed, bulletSpeed, shotRange)
  self.damage = damage
  self.movementSpeed = movementSpeed
  self.shotSpeed = shotSpeed
  self.bulletSpeed = bulletSpeed
  self.shotRange = shotRange
end

function Stats:getSpeed()
  return 300 + self.movementSpeed * 20
end

function Stats:getShotRange()
  return 150 + 10 * self.shotRange
end

function Stats:getShotDelay()
  return 0.4 - 0.01 * self.shotSpeed
end

function Stats:getBulletSpeed()
  return 700 + 40 * self.bulletSpeed
end
