local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
  for i, v in pairs(self.targets) do
    local velocity = v:get("Velocity")
    local position = v:get("Position")
    position:setVector(position:toVector() + velocity:toVector() * dt)
  end
end

function MovementSystem:requires()
  return {"Position", "Velocity"}
end

return MovementSystem
