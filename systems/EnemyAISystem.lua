local EnemyAISystem = class("EnemyAISystem", System)

local MovementModes = require "systems/ai/MovementModes"
local AttackModes = require "systems/ai/AttackModes"

local Actions = require "systems/ai/Actions"
local Prerequisites = require "systems/ai/Prerequisites"

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
    local AI = enemy:get("AI")
    local action = AI:getAction(AI.goal)
    local accomplished = false
    repeat
      accomplished = true
      for _, prerequisite in pairs(action.prerequisites) do
        print(prerequisite.name)
        accomplished = Prerequisites[prerequisite.name](action.name, prerequisite, enemy, player, dt)
        if not accomplished then
          action = AI:getAction(prerequisite)
          break
        end
      end
    until accomplished or not action
    if action == nil then
      action = Actions.Idle
    end
    action.perform(enemy, player, dt)
  end
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Circle", "AI" },
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer" }
  }
end

return EnemyAISystem
