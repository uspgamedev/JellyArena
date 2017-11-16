local Actions = {}

local function MeleeAction(agent, target, dt)
  local attack = Utils.getChild(agent, "MeleeAttack")
  local globalTimer = agent:get("Timer")
  local attackTimer = attack:get("Timer")
  local attackProperties = attack:get("AttackProperties")
  local range = attack:get("AttackRange")
  local attackDamage = attack:get("Damage").damage
  local radius = agent:get("Circle").radius + range.max
  local damage = createDamageArea(agent:get("Position"), radius, attackDamage, agent)
  Utils.getEngine():addEntity(damage)
  table.insert(garbageList, damage)
  attackTimer:start()
  globalTimer:start()
  return true
end

local function RangedAction(agent, target, dt)
  local attack = Utils.getChild(agent, "RangedAttack")
  local globalTimer = agent:get("Timer")
  local attackTimer = attack:get("Timer")
  local attackProperties = attack:get("AttackProperties")
  local range = attack:get("AttackRange")
  local attackDamage = attack:get("Damage").damage
  local position = agent:get("Position")
  local direction = (target:get("Position"):toVector() - position:toVector())
  local bulletSpeed = agent:get("Stats"):getBulletSpeed()
  direction:normalizeInplace()
  bullet = createEnemyBullet(agent, position.x, position.y, direction, attackDamage, range.max, bulletSpeed)
  Utils.getEngine():addEntity(bullet)
  attackTimer:start()
  globalTimer:start()
  return true
end

local function DashAttackAction(agent, target, dt)
  local agentVelocity = agent:get("Velocity")
  local agentPosition = agent:get("Position")
  local state = agent:get("AI").currentState
  local attack = Utils.getChild(agent, "DashAttack")
  local globalTimer = agent:get("Timer")
  local attackTimer = attack:get("Timer")
  local range = attack:get("AttackRange")

  if not state.travelledDistance then
    -- lock target
    local direction = (target:get("Position"):toVector() - agentPosition:toVector())
    direction:normalizeInplace()
    agentVelocity.speed = 1000
    agentVelocity:setDirection(direction)
    state.travelledDistance = 0

    -- damaging area around agent
    local attackProperties = attack:get("AttackProperties")
    local attackDamage = attack:get("Damage").damage
    local radius = agent:get("Circle").radius
    state.damage = createDamageArea(agentPosition, radius, attackDamage, agent, true)
    Utils.getEngine():addEntity(state.damage)
  end

  -- finish dash and enter cooldown
  if state.travelledDistance > range.max then
    agentVelocity.speed = 0

    if not state.waitTime then
      table.insert(garbageList, state.damage)
      attackTimer:start()
      globalTimer:start()
      state.waitTime = 0
    end

    state.waitTime = state.waitTime + dt
    if state.waitTime > 1 then
      return true
    else
      return false
    end
  end

  state.travelledDistance = state.travelledDistance + dt * agentVelocity.speed
  return false;
end

Actions.MeleeAttack = {
  name = "MeleeAttack",
  cost = function(agent, target, dt)
    return 0
  end,
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
  requiredChildrenEntities = {
    "MeleeAttack"
  },
  perform = MeleeAction
}

Actions.RangedAttack = {
  name = "RangedAttack",
  cost = function(agent, target, dt)
    return 0
  end,
  prerequisites = {
    {
      name = "InAttackRange",
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
  requiredChildrenEntities = {
    "RangedAttack"
  },
  perform = RangedAction
}

Actions.DashAttack = {
  name = "DashAttack",
  cost = function(agent, target, dt)
    return 0
  end,
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player"
    },
    {
      name = "AttackAvailable",
      target = "DashAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "DashAttack"
  },
  perform = DashAttackAction
}

Actions.DashFollow = {
  name = "DashFollow",
  cost = function(agent, target, dt)
    local agentPosition = agent:get("Position")
    local targetPosition = target:get("Position")
    local distance = (agentPosition:toVector() - targetPosition:toVector()):len()
    return distance
  end,
  prerequisites = {},
  effects = {
    {
      name = "InAttackRange",
      target = "Player"
    }
  },
  requiredChildrenEntities = {},
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    local state = agent:get("AI").currentState
    local range = 200

    if not state.travelledDistance then
      -- lock target
      local direction = (target:get("Position"):toVector() - agentPosition:toVector())
      direction:normalizeInplace()
      agentVelocity.speed = 1000
      agentVelocity:setDirection(direction)
      state.travelledDistance = 0
    end

    -- finish dash and enter cooldown
    if state.travelledDistance > range then
      agentVelocity.speed = 0

      state.waitTime = state.waitTime or 0
      state.waitTime = state.waitTime + dt
      if state.waitTime > 0.5 then
        return true
      else
        return false
      end
    end

    state.travelledDistance = state.travelledDistance + dt * agentVelocity.speed
    return false
  end
}

Actions.FollowPlayer = {
  name = "FollowPlayer",
  cost = function(agent, target, dt)
    local agentPosition = agent:get("Position")
    local targetPosition = target:get("Position")
    local distance = (agentPosition:toVector() - targetPosition:toVector()):len()
    return distance
  end,
  prerequisites = {},
  effects = {
    {
      name = "InAttackRange",
      target = "Player"
    }
  },
  requiredChildrenEntities = {},
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
  cost = function(agent, target, dt)
    local agentPosition = agent:get("Position")
    local targetPosition = target:get("Position")

    local distance = (agentPosition:toVector() - targetPosition:toVector()):len()

    return 200-distance
  end,
  prerequisites = {
    {
      name = "InDangerRange",
      target = "Player"
    }
  },
  effects = {
    {
      name = "Safety"
    }
  },
  requiredChildrenEntities = {},
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
  requiredChildrenEntities = {},
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    agentVelocity:setDirection(Vector(0, 0))
    return true
  end
}

return Actions
