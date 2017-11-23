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

function DefaultAttackConstructors.BasicMeleeAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BasicMeleeAttack"))
  entity:add(Timer(1 - 0.2 * (level - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(level * 2))
  entity:add(AttackRange(2))
  Enemy.setSpeed(parent, level * 100 + 250)
  Enemy.addBonusHitpoints(parent,level * 10)
  return entity
end

function DefaultAttackConstructors.BasicRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BasicRangedAttack"))
  entity:add(Timer(2 - 0.5 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level))
  entity:add(AttackRange(level * 200))
  Enemy.setSpeed(parent, level * 50 + 200)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.FastRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("FastRangedAttack"))
  entity:add(Timer(0.4 - 0.05 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level))
  entity:add(AttackRange(level * 150))
  Enemy.setSpeed(parent, level * 50 + 250)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.BasicDashAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BasicDashAttack"))
  entity:add(Timer(4 - (level - 1)))
  entity:add(AttackProperties(8))
  entity:add(Damage(level * 4))
  entity:add(AttackRange(level * 150))
  Enemy.setSpeed(parent, level * 50 + 300)
  Enemy.addBonusHitpoints(parent, level * 10)
  return entity
end
