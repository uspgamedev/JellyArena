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
    local nextActionData =  {action = Actions.Idle, cost = math.huge }
    local actionStack = Stack()
    local acomplished
    if AI.currentAction then
      nextActionData = { action = AI.currentAction }
    else
      actionStack:multiPush(map(actions, function(a) return {action = a, cost = a.cost(enemy, player, dt)} end))
      repeat
        actionData = actionStack:pop()
        action = actionData.action
        accomplished = true
        for _, prerequisite in pairs(action.prerequisites) do
          accomplished = accomplished and Prerequisites[prerequisite.name](action.name, prerequisite, enemy, player, dt)
          if not accomplished then
            actionStack:multiPush(map(AI:getActions(prerequisite), function(a) return {action = a, cost = actionData.cost + a.cost(enemy, player, dt)} end))
            break
          end
        end
        if accomplished and actionData.cost < nextActionData.cost then
          nextActionData = actionData
        end
      until actionStack:isEmpty()
    end

    nextAction = nextActionData.action

    if nextAction.perform(enemy, player, dt) then
      AI.currentState = {}
      AI.currentAction = nil
    else
      AI.currentAction = nextAction
    end
  end
end

function map(list, func)
  result = {}
  for _, item in ipairs(list) do
    table.insert(result, func(item))
  end
  return result
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Circle", "AI"},
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer"}
  }
end

return EnemyAISystem
