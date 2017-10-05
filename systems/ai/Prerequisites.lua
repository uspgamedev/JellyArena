local Prerequisites = {}

function Prerequisites.InAttackRange(action, prerequisite, agent, target, dt)
  local attack = getAttack(agent, action)
  if attack then
    local range = attack:get("AttackRange")
    local agentPosition = agent:get("Position")
    local targetPosition = target:get("Position")

    local distance = (agentPosition:toVector() - targetPosition:toVector()):len()
    local distance = distance - agent:get("Circle").radius - target:get("Circle").radius
    if (distance < range.max) then
      return true
    end
  end
  return false
end

function Prerequisites.InSafeRange(action, prerequisite, agent, target, dt)
  local attack = getAttack(agent, action)
  if attack then
    local range = attack:get("AttackRange")
    local agentPosition = agent:get("Position")
    local targetPosition = target:get("Position")

    local distance = (agentPosition:toVector() - targetPosition:toVector()):len()
    local distance = distance - agent:get("Circle").radius - target:get("Circle").radius
    if (distance > range.min) then
      return true
    end
  end
  return false
end

function Prerequisites.AttackAvailable(action, prerequisite, agent, target, dt)
  local attack = getAttack(agent, prerequisite.target)
  local globalTimer = agent:get("Timer")
  if attack then
    local attackTimer = attack:get("Timer")
    if (attackTimer.cooldown <= 0 and globalTimer.cooldown <= 0) then
      return true
    end
  end
  return false
end

return Prerequisites
