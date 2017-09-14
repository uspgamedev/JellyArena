local IsEnemy = Component.create("IsEnemy")

function IsEnemy:initialize(movementMode, attackMode)
  self.movementMode = movementMode
  self.attackMode = attackMode
end
