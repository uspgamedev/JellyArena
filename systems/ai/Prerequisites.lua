local Prerequisites = {}

function Prerequisites.InRange(prerequisite, agent, target, dt)
  local range = 2
  local agentPosition = agent:get("Position")
  local targetPosition = target:get("Position")

  local distance = (agentPosition:toVector() - targetPosition:toVector()):len()
  local distance = distance - agent:get("Circle").radius - target:get("Circle").radius
  if (distance < range) then
    return true
  end
  return false
end

function Prerequisites.AttackAvailable(prerequisite, agent, target, dt)
  local attack = getAttack(agent, prerequisite.target)
  if attack then
    local attackTimer = attack:get("Timer")
    if (attackTimer.cooldown <= 0) then
      return true
    end
  end
  return false
end

return Prerequisites
