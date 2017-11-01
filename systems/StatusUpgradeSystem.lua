local StatusUpgradeSystem = class("StatusUpgradeSystem", System)

function StatusUpgradeSystem:update(dt)
  local player = nil
  -- get first player
  for _,p in pairs(self.targets.Player) do
    player = p
    break
  end

  for i, upgrade in pairs(self.targets.Upgrades) do
    playerStats = player:get("Stats")
    upgradeStats = upgrade:get("Stats")
    playerStats.damage = upgradeStats.damage
    playerStats.movementSpeed = upgradeStats.movementSpeed
    playerStats.shotSpeed = upgradeStats.shotSpeed
    playerStats.bulletSpeed = upgradeStats.bulletSpeed
    playerStats.shotRange = upgradeStats.shotRange
    Utils.getEngine():removeEntity(upgrade)
  end
end

function StatusUpgradeSystem:requires()
  return {
    Player = {"Stats", "IsPlayer" },
    Upgrades = {"Stats", "Timer" }
  }
end

return StatusUpgradeSystem
