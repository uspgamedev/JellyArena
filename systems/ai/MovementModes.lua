local Modes = {}

function Modes.FollowPlayer(enemy, player, dt)
  local enemyVelocity = enemy:get("Velocity")
  local enemyPosition = enemy:get("Position")

  local distance = enemyVelocity.maxSpeed*dt -- distance the enemy can walk
  local direction = (player:get("Position"):toVector() - enemyPosition:toVector())
  local maxDistance = direction:len() - enemy:get("Circle").radius - player:get("Circle").radius -- distance between enemy and player
  direction:normalizeInplace()
  enemyVelocity:setDirection(direction)

  if(distance > maxDistance) then
    enemyVelocity.speed = maxDistance/dt
  else
    enemyVelocity.speed = distance/dt
  end
end

return Modes
