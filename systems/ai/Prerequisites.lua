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
  local attackTimer = agent:get("Timer")
  if (attackTimer.cooldown > 0) then
    return false
  end
  return true
end

return Prerequisites
