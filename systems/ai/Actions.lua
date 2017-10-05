local Actions = {}

Actions.MeleeAttack = {
  name = "MeleeAttack",
  score = 10,
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player"
    },
    {
      name = "AttackAvailable",
      target = "MeleeAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  perform = function(agent, target, dt)
    local attack = getAttack(agent, "MeleeAttack")
    local globalTimer = agent:get("Timer")
    local attackTimer = attack:get("Timer")
    local attackProperties = attack:get("AttackProperties")
    local range = attack:get("AttackRange")
    local attackDamage = attack:get("Damage").damage
    local radius = agent:get("Circle").radius + range.max
    local damage = createDamageArea(agent:get("Position"), radius, attackDamage)
    engine:addEntity(damage)
    table.insert(garbage_list, damage)
    attackTimer:start()
    globalTimer:start()
    return true
  end
}

Actions.RangedAttack = {
  name = "RangedAttack",
  score = 8,
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player"
    },
    {
      name = "InSafeRange",
      target = "Player"
    },
    {
      name = "AttackAvailable",
      target = "RangedAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  perform = function(agent, target, dt)
    local attack = getAttack(agent, "RangedAttack")
    local globalTimer = agent:get("Timer")
    local attackTimer = attack:get("Timer")
    local attackProperties = attack:get("AttackProperties")
    local range = attack:get("AttackRange")
    local attackDamage = attack:get("Damage").damage
    local position = agent:get("Position")
    local direction = (target:get("Position"):toVector() - position:toVector())
    direction:normalizeInplace()
    bullet = createEnemyBullet(position.x, position.y, direction, attackDamage, range.max)
    engine:addEntity(bullet)
    attackTimer:start()
    globalTimer:start()
    return true
  end
}

Actions.DashAttack = {
  name = "DashAttack",
  score = 10,
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    local state = agent:get("AI").currentState

    if not state.travelledDistance then
      print("Primeira vez")
      local direction = (target:get("Position"):toVector() - agentPosition:toVector())
      direction:normalizeInplace()
      agentVelocity.speed = 1000
      agentVelocity.direction = direction
      state.travelledDistance = 0
    end

    if state.travelledDistance > 300 then
    print("ultima vez")
      agentVelocity.speed = agentVelocity.maxSpeed
      return true
    end

    print(agentVelocity.speed)
    state.travelledDistance = state.travelledDistance + dt * agentVelocity.speed
    return false;
  end
}

Actions.FollowPlayer = {
  name = "FollowPlayer",
  score = 2,
  prerequisites = {},
  effects = {
    {
      name = "InAttackRange",
      target = "Player"
    }
  },
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")

    local distance = agentVelocity.maxSpeed * dt -- distance the agent can walk
    local direction = (target:get("Position"):toVector() - agentPosition:toVector())
    local maxDistance = direction:len() - agent:get("Circle").radius - target:get("Circle").radius -- distance between agent and target
    direction:normalizeInplace()
    agentVelocity:setDirection(direction)

    if (distance > maxDistance) then
      agentVelocity.speed = maxDistance / dt
    else
      agentVelocity.speed = distance / dt
    end
  return true
  end
}

Actions.FleeFromPlayer = {
  name = "FleeFromPlayer",
  score = 2,
  prerequisites = {},
  effects = {
    {
      name = "InSafeRange",
      target = "Player"
    }
  },
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    local targetVelocity = target:get("Velocity")
    local targetPosition = target:get("Position")

    local distance = agentVelocity.maxSpeed * dt -- distance the agent can walk
    local currentDistance = (agentPosition:toVector() - targetPosition:toVector()):len()
    local direction = (agentPosition:toVector() - targetPosition:toVector())
    direction:normalizeInplace()
    agentVelocity:setDirection(direction)
    return true
  end
}

Actions.Idle = {
  name = "Idle",
  score = 1,
  prerequisites = {},
  effects = {},
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    agentVelocity:setDirection(Vector(0, 0))
    return true
  end
}

return Actions
