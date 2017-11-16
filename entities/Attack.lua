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
  entity:add(Timer(1 - 0.2 * (stats.shotSpeed - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(stats.damage * 2))
  entity:add(AttackRange(2))
  return entity
end

function DefaultAttackConstructors.BasicRangedAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("BasicRangedAttack"))
  entity:add(Timer(1 - 0.5 * (stats.shotSpeed - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(stats.damage))
  entity:add(AttackRange(stats.shotRange * 200))
  return entity
end

function DefaultAttackConstructors.DashAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("DashAttack"))
  entity:add(Timer(4 - (stats.shotSpeed - 1)))
  entity:add(AttackProperties(8))
  entity:add(Damage(stats.damage * 4))
  entity:add(AttackRange(stats.shotRange * 150))
  return entity
end
