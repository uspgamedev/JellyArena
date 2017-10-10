learning = {}

local Actions = require "systems/ai/Actions"

function createLearningList()
  effects = getEffects()
  for k,v in pairs(effects) do
    for l,u in pairs(v) do
      print(l,u)
    end
    for l,u in pairs(v.actions) do
      v.actions[l] = 1.0/v.size
      print(l,v.actions[l])
    end
    print()
  end
end
