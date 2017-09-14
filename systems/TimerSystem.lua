local TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
  for _, target in pairs(self.targets) do
    local timer = target:get("Timer")
    lovetoys.debug(timer.cooldown)
    if timer.isActive then
      timer.cooldown = timer.cooldown - dt
      if timer.cooldown <= 0 then
        timer.isActive = false
      end
    end
  end
end

function TimerSystem:requires()
  return {"Timer"}
end

return TimerSystem
