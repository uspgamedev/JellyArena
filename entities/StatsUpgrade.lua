local Stats = Component.load({"Stats"})

function createStatsUpgrade(damage, movement_speed, shot_speed, bullet_speed, shot_range, duration)
  local entity = Entity()
  entity:add(Stats(damage, movement_speed, shot_speed, bullet_speed, shot_range))
  entity:add(Timer(duration))
  return entity
end
