local BulletProperties  = Component.create("BulletProperties")

function BulletProperties:initialize(speed, radius)
  self.speed = speed
  self.radius = radius
end
