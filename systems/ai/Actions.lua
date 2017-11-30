local Actions = {}

local function MeleeAction(agent, target, label, dt)
  print("atack")
  local attack = Utils.getChild(agent, label)
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

local function RangedAction(agent, target, label, dt)
  local attack = Utils.getChild(agent, label)
  local globalTimer = agent:get("Timer")
  local attackTimer = attack:get("Timer")
  local attackProperties = attack:get("AttackProperties")
  local range = attack:get("AttackRange")
  local attackDamage = attack:get("Damage").damage
  local position = agent:get("Position")
  local direction = (target:get("Position"):toVector() - position:toVector())
  local bulletSpeed = attack:get("BulletProperties").speed
  local bulletRadius = attack:get("BulletProperties").radius
  direction:normalizeInplace()
  local bulletPos = position:toVector() + attackProperties.spawnDistance * direction
  bullet = createEnemyBullet(agent, bulletPos.x, bulletPos.y, direction, attackDamage, range.max, bulletSpeed, bulletRadius)
  Utils.getEngine():addEntity(bullet)
  attackTimer:start()
  globalTimer:start()
  return true
end

local function DashAttackAction(agent, target, label, dt)
  local agentVelocity = agent:get("Velocity")
  local agentPosition = agent:get("Position")
  local state = agent:get("AI").currentState
  local attack = Utils.getChild(agent, label)
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

local function SetTrapAction(agent, target, label, dt)
  local attack = Utils.getChild(agent, label)
  local globalTimer = agent:get("Timer")
  local attackTimer = attack:get("Timer")
  local attackProperties = attack:get("AttackProperties")
  local attackDamage = attack:get("Damage").damage
  local position = agent:get("Position")
  local trap = createDamageTrap(position.x, position.y, agent, attackDamage)
  Utils.getEngine():addEntity(trap)
  attackTimer:start()
  globalTimer:start()
  return true
end

Actions.BasicMeleeAttack = {
  name = "BasicMeleeAttack",
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
      target = "BasicMeleeAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "BasicMeleeAttack"
  },
  perform = function(agent, target, dt)
    return MeleeAction(agent, target, "BasicMeleeAttack", dt)
  end
}

Actions.LightMeleeAttack = {
  name = "LightMeleeAttack",
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
      target = "LightMeleeAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "LightMeleeAttack"
  },
  perform = function(agent, target, dt)
    return MeleeAction(agent, target, "LightMeleeAttack", dt)
  end
}

Actions.BasicRangedAttack = {
  name = "BasicRangedAttack",
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
      target = "BasicRangedAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "BasicRangedAttack"
  },
  perform = function(agent, target, dt)
    return RangedAction(agent, target, "BasicRangedAttack", dt)
  end
}

Actions.FastRangedAttack = {
  name = "FastRangedAttack",
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
      target = "FastRangedAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "FastRangedAttack"
  },
  perform = function(agent, target, dt)
    return RangedAction(agent, target, "FastRangedAttack", dt)
  end
}

Actions.SniperRangedAttack = {
  name = "SniperRangedAttack",
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
      target = "SniperRangedAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "SniperRangedAttack"
  },
  perform = function(agent, target, dt)
    return RangedAction(agent, target, "SniperRangedAttack", dt)
  end
}

Actions.BigRangedAttack = {
  name = "BigRangedAttack",
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
      target = "BigRangedAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "BigRangedAttack"
  },
  perform = function(agent, target, dt)
    return RangedAction(agent, target, "BigRangedAttack", dt)
  end
}

Actions.BasicDashAttack = {
  name = "BasicDashAttack",
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
      target = "BasicDashAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "BasicDashAttack"
  },
  perform = function(agent, target, dt)
    return DashAttackAction(agent, target, "BasicDashAttack", dt)
  end
}

Actions.SetTrap = {
  name = "SetTrap",
  cost = function(agent, target, dt)
    return 0
  end,
  prerequisites = {
    {
      name = "AttackAvailable",
      target = "SetTrap"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "SetTrap"
  },
  perform = function(agent, target, dt)
    return SetTrapAction(agent, target, "SetTrap", dt)
  end
}

Actions.SlowBigDashAttack = {
  name = "SlowBigDashAttack",
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
      target = "SlowBigDashAttack"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  requiredChildrenEntities = {
    "SlowBigDashAttack"
  },
  perform = function(agent, target, dt)
    return DashAttackAction(agent, target, "SlowBigDashAttack", dt)
  end
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
    local range = agentVelocity.maxSpeed * 0.5

    if not state.travelledDistance then
      -- lock target
      local direction = (target:get("Position"):toVector() - agentPosition:toVector())
      direction:normalizeInplace()
      agentVelocity.speed = agentVelocity.maxSpeed * 2
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

Actions.Scout = {
  name = "Scout",
  cost = function()
    return math.huge
  end,
  prerequisites = {},
  effects = {
    {
      name = "Scout"
    }
  },
  requiredChildrenEntities = {},
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")

    local direction = nil
    local mapSize = Utils.mapDefinitions
    if agentPosition.x < mapSize.width*0.1 or agentPosition.x > mapSize.width*0.9 or
        agentPosition.y < mapSize.height*0.1 or agentPosition.y > mapSize.height*0.9 then

      direction = Vector(mapSize.width/2, mapSize.height/2) - agentPosition:toVector()
      direction:normalizeInplace()
    else
      local angle = (math.random() - 0.5) * math.pi / 8
      direction = agentVelocity:getDirection():rotated(angle)
    end
    agentVelocity:setDirection(direction)
    return true
  end
}

Actions.Idle = {
  name = "Idle",
  cost = function()
    return math.huge
  end,
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
