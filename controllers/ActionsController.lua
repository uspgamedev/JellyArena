local actionsController = {}

local Actions = require "systems/ai/Actions"

function actionsController.addEffect(effects, action, effect)
  for i, e in ipairs(effects) do
    if effect.name == e.name and effect.target == e.target then
      e.actions[action] = 0
      e.size = e.size + 1
      return
    end
  end
  effect.actions = {}
  effect.actions[action] = 0
  effect.size = 1
  table.insert(effects, effect)
end

-- creates a list of effects and actions with such effects
-- example: {{name=Damage, actions={Dash: 0, Ranged: 0, Melee: 0}}, ...}
function actionsController.getEffects()
  local effects = {}
  for action, v in pairs(Actions) do
    for _, effect in pairs(v.effects) do
      ActionsController.addEffect(effects, action, effect)
    end
  end
  return effects
end

return actionsController
