local AI = Component.create("AI")

function AI:initialize(goals, actions)
  self.goals = goals
  self.actions = actions
  self.currentState = {}
  self.currentAction = nil
end

function AI:getAction(effect)
  for _, action in pairs(self.actions) do
    for _, e in pairs(action.effects) do
      if (e.name == effect.name and e.target == effect.target) then
        return action
      end
    end
  end
  return nil
end

function AI:getActions(effect)
  local result = {}
  for _, action in pairs(self.actions) do
    for _, e in pairs(action.effects) do
      if (e.name == effect.name and e.target == effect.target) then
        table.insert(result, action)
      end
    end
  end
  return result
end
