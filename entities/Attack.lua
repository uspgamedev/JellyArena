local Label, Timer, AttackProperties, Damage, AttackRange, BulletProperties
= Component.load({"Label", "Timer", "AttackProperties", "Damage", "AttackRange", "BulletProperties"})

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
  entity:add(Timer(1 - 0.4 * (level - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(level * 2))
  entity:add(AttackRange(2))
  Enemy.setSpeed(parent, level * 100 + 250)
  Enemy.addBonusHitpoints(parent,level * 10)
  return entity
end

function DefaultAttackConstructors.LightMeleeAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("LightMeleeAttack"))
  entity:add(Timer(1 - 0.4 * (level - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(level))
  entity:add(AttackRange(2))
  Enemy.setSpeed(parent, level * 150 + 350)
  Enemy.addBonusHitpoints(parent,level * 5)
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
  entity:add(BulletProperties(level * 100 + 600, 4 + level))
  Enemy.setSpeed(parent, level * 50 + 200)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.FastRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("FastRangedAttack"))
  entity:add(Timer(0.4 - 0.1 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level))
  entity:add(AttackRange(level * 150))
  entity:add(BulletProperties(level * 100 + 500, 2 + level))
  Enemy.setSpeed(parent, level * 50 + 250)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.SniperRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("SniperRangedAttack"))
  entity:add(Timer(1.5 - 0.3 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level * 2))
  entity:add(AttackRange(level * 800))
  entity:add(BulletProperties(level * 600, 4 + level))
  Enemy.setSpeed(parent, level * 50 + 50)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.BigRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BigRangedAttack"))
  entity:add(Timer(2 - 0.4 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level * 3))
  entity:add(AttackRange(level * 500))
  entity:add(BulletProperties(level * 200, 10 + 5 * level))
  Enemy.setSpeed(parent, level * 50 + 200)
  Enemy.addBonusHitpoints(parent, level * 7)
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

function DefaultAttackConstructors.SlowBigDashAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("SlowBigDashAttack"))
  entity:add(Timer(4 - (level - 1)))
  entity:add(AttackProperties(8))
  entity:add(Damage(level * 4))
  entity:add(AttackRange(level * 500))
  Enemy.setSpeed(parent, level * 100)
  Enemy.addBonusHitpoints(parent, level * 15)
  return entity
end
