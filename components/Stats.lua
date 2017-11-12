local Stats = Component.create("Stats")

function Stats:initialize(damage, movement_speed, shot_speed, bullet_speed, shot_range)
  self.damage = damage
  self.movement_speed = movement_speed
  self.shot_speed = shot_speed
  self.bullet_speed = bullet_speed
  self.shot_range = shot_range
end
