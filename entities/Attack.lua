local Label, Timer, AttackProperties
  = Component.load({"Label", "Timer", "AttackProperties"})

function createPlayerAttack (parent)
  local entity = Entity(parent)
  entity:add(Label("RangedAttack"))
  entity:add(Timer(0.3))
  entity:add(AttackProperties(5, 250, 25))
  return entity
end
