local CombatSystem = class("CombatSystem", System)

local Attacks = {}

function CombatSystem:update(dt)
  for i, target in pairs(self.targets) do
    local combat = target:get("Combat")
    combat.cooldown = combat.cooldown - dt
    if(combat.cooldown < 0) then combat.cooldown = 0 end
  end

  for i, target in pairs(self.targets) do
    local combat = target:get("Combat")
    if combat.attackDirection and combat.cooldown == 0 then
      Attacks[combat.attackType](combat, target:get("Position"))
      combat.cooldown = combat.fireDelay
    end
  end
end

function CombatSystem:requires()
  return { "Position", "Combat" }
end


-- Attack types functions
function Attacks.SimpleBullet(combat, position)
  engine:addEntity(Bullet(position.x, position.y, combat.attackDirection, combat.attackDmg))
end

function Attacks.PlayerSimpleBullet(combat, position)
  if combat.hp > 1 then
    engine:addEntity(Bullet(position.x, position.y, combat.attackDirection, combat.attackDmg))
    combat.hp = combat.hp - 1
  end
end

return CombatSystem
