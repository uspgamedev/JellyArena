local PlayerUpgradeSystem = class("PlayerUpgradeSystem", System)

function PlayerUpgradeSystem:update(dt)
  for _, target in pairs(self.targets) do
    local timer = target:get("Timer")
    --lovetoys.debug(timer.cooldown)
    if timer.isActive then
      timer.cooldown = timer.cooldown - dt
      if timer.cooldown <= 0 then
        timer.isActive = false
      end
    end
  end
end

function PlayerUpgradeSystem:requires()
  return {"isPlayer"}
end

return PlayerUpgradeSystem
