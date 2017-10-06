local EnemyAISystem = class("EnemyAISystem", System)

local Actions = require "systems/ai/Actions"
local Prerequisites = require "systems/ai/Prerequisites"

function EnemyAISystem:update(dt)
  local player = nil
  -- get first player
  for _, p in pairs(self.targets.Player) do
    player = p
    break
  end
  -- continue only if player exists
  if player == nil then
    return
  end

  for i, enemy in pairs(self.targets.Enemies) do
    local AI = enemy:get("AI")
    local actions = AI:getActions(AI.goal)
    local nextAction = Actions.Idle
    local actionStack = Stack()
    local acomplished
    if AI.currentAction then
      print("Continuando "..AI.currentAction.name)
      nextAction = AI.currentAction
    else
      actionStack:multiPush(actions)
      repeat
        action = actionStack:pop()
        accomplished = true
        for _, prerequisite in pairs(action.prerequisites) do
          accomplished = accomplished and Prerequisites[prerequisite.name](action.name, prerequisite, enemy, player, dt)
          if not accomplished then
            actionStack:multiPush(AI:getActions(prerequisite))
            break
          end
        end
        if accomplished and action.score > nextAction.score then
          nextAction = action
        end
      until actionStack:isEmpty()
    end

    if nextAction.perform(enemy, player, dt) then
      print("Acabou "..nextAction.name)
      AI.currentState = {}
      AI.currentAction = nil
    else
      print("Executando "..nextAction.name)
      AI.currentAction = nextAction
    end
  end
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Circle", "AI"},
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer"}
  }
end

return EnemyAISystem
