local EnemyAISystem = class("EnemyAISystem", System)

local MovementModes = require "systems/ai/MovementModes"
local AttackModes = require "systems/ai/AttackModes"

function EnemyAISystem:update(dt)
  local player = nil
  -- get first player
  for _,p in pairs(self.targets.Player) do
    player = p
    break
  end
  -- continue only if player exists
  if player == nil then return end

  for i, enemy in pairs(self.targets.Enemies) do
    MovementModes[enemy:get("IsEnemy").movementMode](enemy, player, dt)
    AttackModes[enemy:get("IsEnemy").attackMode](enemy, player, dt)

  end
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Circle", "IsEnemy" },
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer" }
  }
end

return EnemyAISystem
