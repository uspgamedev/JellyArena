local Label, Timer, AttackProperties, Damage, AttackRange
= Component.load({"Label", "Timer", "AttackProperties", "Damage", "AttackRange"})

function createPlayerAttack(parent)
  local entity = Entity(parent)
  entity:add(Label("RangedAttack"))
  entity:add(Timer(0.3))
  entity:add(AttackProperties(25))
  entity:add(Damage(5))
  entity:add(AttackRange(250, 0))
  return entity
end

function createMeleeAttack(parent)
  local entity = Entity(parent)
  entity:add(Label("MeleeAttack"))
  entity:add(Timer(1))
  entity:add(AttackProperties(0))
  entity:add(Damage(2))
  entity:add(AttackRange(2, 0))
  return entity
end

function createRangedAttack(parent)
  local entity = Entity(parent)
  entity:add(Label("RangedAttack"))
  entity:add(Timer(0.5))
  entity:add(AttackProperties(25))
  entity:add(Damage(1))
  entity:add(AttackRange(500, 100))
  return entity
end
