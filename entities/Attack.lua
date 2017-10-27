local Label, Timer, AttackProperties, Damage, AttackRange
= Component.load({"Label", "Timer", "AttackProperties", "Damage", "AttackRange"})

function createPlayerAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("RangedAttack"))
  entity:add(Timer(getShotDelay(stats.shot_speed)))
  entity:add(AttackProperties(25))
  entity:add(Damage(1))
  entity:add(AttackRange(getShotRange(stats.shot_range)))
  return entity
end

function createMeleeAttack(parent)
  local entity = Entity(parent)
  entity:add(Label("MeleeAttack"))
  entity:add(Timer(1))
  entity:add(AttackProperties(0))
  entity:add(Damage(2))
  entity:add(AttackRange(2))
  return entity
end

function createRangedAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("RangedAttack"))
  entity:add(Timer(getShotDelay(stats.shot_speed)))
  entity:add(AttackProperties(25))
  entity:add(Damage(1))
  entity:add(AttackRange(getShotRange(stats.shot_range)))
  return entity
end

function createDashAttack(parent)
  local entity = Entity(parent)
  local stats = parent:get("Stats")
  entity:add(Label("DashAttack"))
  entity:add(Timer(2))
  entity:add(AttackProperties(8))
  entity:add(Damage(1))
  entity:add(AttackRange(200))
  return entity
end
