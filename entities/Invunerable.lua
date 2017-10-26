local Timer, Label = Component.load({"Timer", "Label"})

function createInvunerable(parent)
  local entity = Entity(parent)
  entity:add(Timer(1))
  entity:add(Label("Invunerable"))
  return entity
end
