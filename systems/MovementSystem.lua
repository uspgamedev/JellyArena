local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
  for i, v in pairs(self.targets.movables) do
    local velocity = v:get("Velocity")
    local position = v:get("Position")

    position:setVector(position:toVector() + velocity:toVector() * dt)
  end

  for i, v in pairs(self.targets.followers) do
    local position = v:get("Position")
    local follow = v:get("Follow")
    position:setVector(follow.target:get("Position"):toVector())
  end
  for _,p in ipairs(self.targets.player) do
    local pos = p:get("Position")
    local dx,dy = pos.x - camera.x, pos.y - camera.y
    camera:move(dx/2, dy/2)
  end
end

function MovementSystem:requires()
  return { movables = { "Position", "Velocity" }, followers = {"Position", "Follow"}, player = {"IsPlayer"} }
end

return MovementSystem
