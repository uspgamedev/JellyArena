local AnimationSystem = class("AnimationSystem", System)

function AnimationSystem:update(dt)
  for i,v in pairs(self.targets) do
    local animation = v:get("Animation");
    animation:update(dt)
  end
end

function AnimationSystem:requires()
  return {"Animation"}
end

return AnimationSystem
