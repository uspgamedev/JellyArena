local TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
  for _, target in pairs(self.targets.Timed) do
    local timer = target:get("Timer")
    updateTimer(timer, dt)
  end
  for _, target in pairs(self.targets.LifeTimed) do
    local lifeTime = target:get("LifeTime")
    updateTimer(lifeTime, dt)
    if (lifeTime.cooldown <= 0) then
      lifeTime:kill()
    end
  end
end

function updateTimer(timer, dt)
  --lovetoys.debug(timer.cooldown)
  if timer.isActive then
    timer.cooldown = timer.cooldown - dt
    if timer.cooldown <= 0 then
      timer.isActive = false
    end
  end
end

function TimerSystem:requires()
  return {
    Timed = {"Timer"},
    LifeTimed = {"LifeTime"}
  }
end

return TimerSystem
