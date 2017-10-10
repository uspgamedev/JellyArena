local ProjectileSystem = class("ProjectileSystem", System)

function ProjectileSystem:update(dt)
  for i, v in pairs(self.targets) do
    local projectile = v:get("Projectile")
    local velocity = v:get("Velocity")
    projectile:addDisplacement((velocity:toVector() * dt):len())
    if (not projectile:moving()) then
      velocity:setDirection(Vector(0, 0))
      if projectile.owner == "Player" then
        local position = v:get("Position")
        drop = createHpDrop(position.x, position.y)
        engine:addEntity(drop)
        engine:removeEntity(v)
      else
        table.insert(garbage_list, v)
      end
    end
  end
end

function ProjectileSystem:requires()
  return { "Projectile", "Velocity", "Position" }
end

return ProjectileSystem
