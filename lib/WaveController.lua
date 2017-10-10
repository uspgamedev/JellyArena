local learning = {}

local Actions = require "systems/ai/Actions"

function createLearningList()
  learning = getEffects()
  for k,v in pairs(learning) do
    for l,u in pairs(v) do
      -- print(l,u)
    end
    for l,u in pairs(v.actions) do
      v.actions[l] = 1.0/v.size
      -- print(l,v.actions[l])
    end
    -- print()
  end
end

function getActionsWithEffect(effect)
  for k,v in pairs(learning) do
    if v.name == effect.name and v.target == effect.target then
      return v.actions
    end
  end
  return {}
end
