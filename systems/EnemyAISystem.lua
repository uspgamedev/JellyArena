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
    local priorityGoal = { weight = function() return -1 end }
    local nextActionData
    if AI.currentAction then
      nextActionData = { action = AI.currentAction }
    else
      nextActionData =  {action = Actions.Idle, cost = math.huge }
      for _, goal in pairs(AI.goals) do
        local actions = AI:getActions(goal)
        local actionStack = Stack()
        local acomplished

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
          if  accomplished then
            if goal.weight(enemy, player, dt) > priorityGoal.weight(enemy, player, dt) then
              nextActionData = actionData
              priorityGoal = goal
            else if goal.weight(enemy, player, dt) == priorityGoal.weight(enemy, player, dt)
                and actionData.cost < nextActionData.cost then
              nextActionData = actionData
              priorityGoal = goal
            end
          end
        end
        until actionStack:isEmpty()
      end
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
