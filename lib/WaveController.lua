local learning = {}

local currentActions = {}

local Actions = require "systems/ai/Actions"

function createLearningList()
  learning = getEffects()
  for k, v in pairs(learning) do
    for l, u in pairs(v) do
      -- print(l,u)
    end
    for l, u in pairs(v.actions) do
      v.actions[l] = 1.0 / v.size
      -- print(l,v.actions[l])
    end
    -- print()
  end
end

function updateLearning()
  local score = Statistic.getScore()
  print("SCORE:", score)
  Statistic.reset()
  for _, effect in pairs(learning) do
    for action, prob in pairs(effect.actions) do
      if inCurrentActions(action) then
        effect.actions[action] = prob + score
      end
    end
  end
  currentActions = {}
  normalizeProbabilities()
end

function normalizeProbabilities()
  for _, effect in pairs(learning) do
    sum = 0
    for _, prob in pairs(effect.actions) do
      sum = sum + prob
    end
    for action, prob in pairs(effect.actions) do
      effect.actions[action] = prob / sum
      print (action, prob / sum)
    end
  end
end

function getActionsWithEffect(effect)
  for k, v in pairs(learning) do
    if v.name == effect.name and v.target == effect.target then
      return v.actions
    end
  end
  return {}
end

function addCurrentActions(action)
  table.insert(currentActions, action)
end

function inCurrentActions(action)
  for _,a in pairs(currentActions) do
    if a == action then
      return true
    end
  end
  return false
end
