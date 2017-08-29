local EnemyAISystem = class("EnemyAISystem", System)

local Modes = require "systems/ai/MovementModes"

function EnemyAISystem:update(dt)
  local player = self.targets.Player[1]

  for i, enemy in pairs(self.targets.Enemies) do
    Modes[enemy:get("IsEnemy").mode](enemy, player, dt)
  end
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Combat", "Circle", "IsEnemy" },
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer" }
  }
end

return EnemyAISystem
