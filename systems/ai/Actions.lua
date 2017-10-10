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
    local attack = getChild(agent, "MeleeAttack")
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
    local attack = getChild(agent, "RangedAttack")
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
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")
    local state = agent:get("AI").currentState
    local attack = getChild(agent, "DashAttack")
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
      engine:addEntity(state.damage)
    end

    -- finish dash and enter cooldown
    if state.travelledDistance > range.max then
      table.insert(garbage_list, state.damage)
      agentVelocity.speed = 0
      attackTimer:start()
      globalTimer:start()
      return true
    end

    state.travelledDistance = state.travelledDistance + dt * agentVelocity.speed
    return false
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

function addEffect(effects, action, effect)
  for i, e in ipairs(effects) do
    if effect.name == e.name and effect.target == e.target then
      e.actions[action] = 0
      e.size = e.size + 1
      return
    end
  end
  effect.actions = {}
  effect.actions[action] = 0
  effect.size = 1
  table.insert(effects, effect)
end

-- creates a list of effects and actions with such effects
function getEffects()
  local effects = {}
  for action, v in pairs(Actions) do
    for _, effect in pairs(v.effects) do
      addEffect(effects, action, effect)
    end
  end
  return effects
end

return Actions
