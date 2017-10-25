local Modes = {}

function Modes.Melee(enemy, player, dt)
  for _, damage in pairs(enemy.children) do
    getEngine():removeEntity(damage)
  end

  local attackTimer = enemy:get("Timer")
  if (attackTimer.cooldown > 0) then
    return
  end

  local enemyPosition = enemy:get("Position")
  local playerPosition = player:get("Position")

  local distance = (enemyPosition:toVector() - playerPosition:toVector()):len()
  local distance = distance - enemy:get("Circle").radius - player:get("Circle").radius

  if(distance <= 1) then -- distance <= enemy.range-1
    getEngine():addEntity(createDamage(enemy))
    attackTimer:start()
  end

end


return Modes
