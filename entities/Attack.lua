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
  entity:add(Timer(1 - 0.25 * (level - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(level + 1))
  entity:add(AttackRange(2))
  Enemy.setSpeed(parent, level * 70 + 100)
  Enemy.addBonusHitpoints(parent,level * 10)
  return entity
end

function DefaultAttackConstructors.LightMeleeAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("LightMeleeAttack"))
  entity:add(Timer(1 - 0.25 * (level - 1)))
  entity:add(AttackProperties(0))
  entity:add(Damage(level))
  entity:add(AttackRange(2))
  Enemy.setSpeed(parent, level * 75 + 125)
  Enemy.addBonusHitpoints(parent,level * 5)
  return entity
end

function DefaultAttackConstructors.BasicRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BasicRangedAttack"))
  entity:add(Timer(2 - 0.25 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level))
  entity:add(AttackRange(150 + level * 75))
  entity:add(BulletProperties(level * 100 + 300, 7 + level))
  Enemy.setSpeed(parent, level * 50 + 100)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.FastRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("FastRangedAttack"))
  entity:add(Timer(0.5 - 0.1 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level))
  entity:add(AttackRange(100 + level * 50))
  entity:add(BulletProperties(level * 100 + 200, 5 + level))
  Enemy.setSpeed(parent, level * 25 + 150)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.SniperRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("SniperRangedAttack"))
  entity:add(Timer(3 - 0.5 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level + 2))
  entity:add(AttackRange(500 + level * 100))
  entity:add(BulletProperties(300 + level * 125, 7 + (2 *level)))
  Enemy.setSpeed(parent, level * 75)
  Enemy.addBonusHitpoints(parent, level * 5)
  return entity
end

function DefaultAttackConstructors.BigRangedAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BigRangedAttack"))
  entity:add(Timer(2 - 0.25 * (level - 1)))
  entity:add(AttackProperties(25))
  entity:add(Damage(level * 2 + 1))
  entity:add(AttackRange(400 + 100 * level))
  entity:add(BulletProperties(200 + 75 * level, 10 + (5 * level)))
  Enemy.setSpeed(parent, level * 50 + 125)
  Enemy.addBonusHitpoints(parent, level * 7)
  return entity
end

function DefaultAttackConstructors.BasicDashAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("BasicDashAttack"))
  entity:add(Timer(4 - 0.75 * (level - 1)))
  entity:add(AttackProperties(8))
  entity:add(Damage(2 * level + 2))
  entity:add(AttackRange(75 + 75 * level))
  Enemy.setSpeed(parent, level * 50 + 125)
  Enemy.addBonusHitpoints(parent, level * 10)
  return entity
end

function DefaultAttackConstructors.SlowBigDashAttack(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("SlowBigDashAttack"))
  entity:add(AttackProperties(8))
  entity:add(Timer(4.5 - level * 0.5))
  entity:add(Damage(2 * level + 2))
  entity:add(AttackRange(level * 200 + 250))
  Enemy.setSpeed(parent, 20 + level * 10)
  Enemy.addBonusHitpoints(parent, level * 10)
  return entity
end

function DefaultAttackConstructors.SetTrap(parent)
  local entity = Entity(parent)
  local level = parent:get("Level").level
  entity:add(Label("SetTrap"))
  entity:add(Timer(6 - level * 1))
  entity:add(Damage(level * 4 + 1))
  Enemy.setSpeed(parent, level * 50 + 100)
  Enemy.addBonusHitpoints(parent, level * 15)
  return entity
end
