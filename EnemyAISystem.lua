local EnemyAISystem = class("EnemyAISystem", System)

local Modes ={}

function EnemyAISystem:update(dt)
  local player = self.targets.Player[1]

  for i, enemy in pairs(self.targets.Enemies) do
    Modes[enemy:get("IsEnemy").mode](enemy, player, dt)
  end
end

function EnemyAISystem:requires()
  return {
    Enemies = {"Position", "Velocity", "Combat", "Circle", "IsEnemy" },
    Player = {"Position", "Hitpoints", "Circle", "IsPlayer" }
  }
end

function Modes.FollowPlayer(enemy, player, dt)
  local enemyVelocity = enemy:get("Velocity")
  local enemyPosition = enemy:get("Position")

  distance = enemyVelocity.maxSpeed*dt -- distance the enemy can walk
  direction = (player:get("Position"):toVector() - enemyPosition:toVector())
  maxDistance = direction:len() - enemy:get("Circle").radius - player:get("Circle").radius -- distance between enemy and player
  direction:normalizeInplace()
  enemyVelocity:setDirection(direction)

  if(distance > maxDistance) then
    enemyVelocity.speed = maxDistance/dt
  else
    enemyVelocity.speed = distance/dt
  end
end

function Modes.AttackPlayer(enemy, player, dt)
  
end

return EnemyAISystem
