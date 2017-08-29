local TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
  for _, target in pairs(self.targets) do
    local timer = target:get("Timer")
    if timer.isActive then
      timer.cooldown = timer.cooldown - dt
    end
  end
end

function TimerSystem:requires()
  return {"Timer"}
end

return TimerSystem