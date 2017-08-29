local Combat  = Component.create("Combat")

function Combat:initialize(maxHp, fireDelay, attackType, attackDmg)
  self.maxHp = maxHp
  self.hp = self.maxHp
  self.fireDelay = fireDelay
  self.cooldown = 0
  self.attackType = attackType
  self.attackDmg = attackDmg
  self.attackDirection = nil
end

function Combat:attack(direction)
  self.attackDirection = direction
  if not self.attackDirection == nil then
    self.attackDirection = self.attackDirection.normalized()
  end
end
