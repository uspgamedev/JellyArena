local wave = {}
local learning = {}
local ALPHA = 0.5

local currentActions = {}


local Actions = require "systems/ai/Actions"


-- create a list of effects with a list of (action, score)
function wave.createLearningList()
  learning = {}
  currentActions = {}
  learning = ActionsController.getEffects()
  for k, v in pairs(learning) do
    for l, u in pairs(v.actions) do
      v.actions[l] = 1
    end
    v.total = v.size
  end
end

-- update learning list
function wave.updateLearning(waveNumber)
  local alpha = 2.0 / (1 + waveNumber)
  StatisticController.getScore()
  LogController.write("wave", "-LEARNING-")
  for _, effect in pairs(learning) do
    effect.total = 0
    for action, s in pairs(effect.actions) do
      local actionAmount = wave.inCurrentActions(action)
      if actionAmount > 0 then
        local actionScoreNormalized = 1.0 * StatisticController.getActionScore(action) / actionAmount
        local score = 0.8 * actionScoreNormalized + 0.2 * StatisticController.getWaveScore()
        effect.actions[action] = (1 - alpha) * s + alpha * score
      end
      effect.total = effect.total + effect.actions[action]
      LogController.write("wave", action..":\t"..effect.actions[action])
    end
    LogController.write("wave", "^-"..effect.name..": "..effect.total)
  end
  LogController.write("wave", "----------")
  currentActions = {}
  StatisticController.reset()
end

function wave.getActionsWithEffect(effect)
  for k, v in pairs(learning) do
    if v.name == effect.name and v.target == effect.target then
      return {actions = v.actions, total = v.total, size = v.size}
    end
  end
  return {actions = {}, total = 0, size = 0}
end

function wave.addCurrentActions(action)
  if currentActions[action] then
    currentActions[action] = currentActions[action] + 1
  else
    currentActions[action] = 1
  end
end

function wave.inCurrentActions(action)
  if currentActions[action] then
    return currentActions[action]
  end
  return 0
end

return wave