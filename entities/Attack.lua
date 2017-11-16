local Label, Timer, AttackProperties, Damage, AttackRange
= Component.load({"Label", "Timer", "AttackProperties", "Damage", "AttackRange"})

DefaultAttackConstructors = {}

function createPlayerAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("RangedAttack"))
  entity:add(Timer(stats:getShotDelay()))
  entity:add(AttackProperties(25))
  entity:add(Damage(1))
  entity:add(AttackRange(stats:getShotRange()))
  return entity
end

function DefaultAttackConstructors.MeleeAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("MeleeAttack"))
  entity:add(Timer(stats:getShotDelay()))
  entity:add(AttackProperties(0))
  entity:add(Damage(2 * stats.damage))
  entity:add(AttackRange(2))
  return entity
end

function DefaultAttackConstructors.RangedAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("RangedAttack"))
  entity:add(Timer(stats:getShotDelay()))
  entity:add(AttackProperties(25))
  entity:add(Damage(stats.damage))
  entity:add(AttackRange(stats:getShotRange()))
  return entity
end

function DefaultAttackConstructors.DashAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("DashAttack"))
  entity:add(Timer(2 * stats:getShotDelay()))
  entity:add(AttackProperties(8))
  entity:add(Damage(1))
  entity:add(AttackRange(stats:getShotRange()))
  return entity
end
