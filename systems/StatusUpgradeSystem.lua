local StatusUpgradeSystem = class("StatusUpgradeSystem", System)

function StatusUpgradeSystem:update(dt)
  local player = nil
  -- get first player
  for _,p in pairs(self.targets.Player) do
    player = p
    break
  end

  for i, upgrade in pairs(self.targets.Upgrades) do
    player_stats = player:get("Stats")
    upgrade_stats = upgrade:get("Stats")
    player_stats.damage = upgrade_stats.damage
    player_stats.movement_speed = upgrade_stats.movement_speed
    player_stats.shot_speed = upgrade_stats.shot_speed
    player_stats.bullet_speed = upgrade_stats.bullet_speed
    player_stats.shot_range = upgrade_stats.shot_range
    engine:removeEntity(upgrade)
  end
end

function StatusUpgradeSystem:requires()
  return {
    Player = {"Stats", "IsPlayer" },
    Upgrades = {"Stats", "Timer" }
  }
end

return StatusUpgradeSystem
