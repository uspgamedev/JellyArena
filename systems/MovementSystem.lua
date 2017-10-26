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
end

function MovementSystem:requires()
  return { movables = { "Position", "Velocity" }, followers = {"Position", "Follow"} }
end

return MovementSystem
