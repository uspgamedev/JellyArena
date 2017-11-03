local Stats = Component.load({"Stats"})

function createStatsUpgrade(damage, movementSpeed, shotSpeed, bulletSpeed, shotRange, duration)
  local entity = Entity()
  entity:add(Stats(damage, movementSpeed, shotSpeed, bulletSpeed, shotRange))
  entity:add(Timer(duration))
  return entity
end
