local Actions = {}

Actions.MeleeAttack = {
  name = "MeleeAttack",
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player",
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
    local attackTimer = attack:get("Timer")
    local attackProperties = attack:get("AttackProperties")
    local radius = agent:get("Circle").radius + attackProperties.range
    local damage = createDamageArea(agent:get("Position"), radius, attackProperties.damage)
    engine:addEntity(damage)
    table.insert(garbage_list, damage)
    attackTimer:start()
  end
}

Actions.RangedAttack = {
  name = "RangedAttack",
  prerequisites = {
    {
      name = "InAttackRange",
      target = "Player",
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
    local attackTimer = attack:get("Timer")
    local attackProperties = attack:get("AttackProperties")
    local position = agent:get("Position")
    local direction = (target:get("Position"):toVector() - position:toVector())
    direction:normalizeInplace()
    bullet = createEnemyBullet(position.x, position.y, direction, attackProperties.damage, attackProperties.range)
    engine:addEntity(bullet)
    attackTimer:start()
  end
}

Actions.FollowPlayer = {
  name = "FollowPlayer",
  prerequisites = {
  },
  effects = {
    {
      name = "InAttackRange",
      target = "Player"
    }
  },
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")

    local distance = agentVelocity.maxSpeed*dt -- distance the agent can walk
    local direction = (target:get("Position"):toVector() - agentPosition:toVector())
    local maxDistance = direction:len() - agent:get("Circle").radius - target:get("Circle").radius -- distance between agent and target
    direction:normalizeInplace()
    agentVelocity:setDirection(direction)

    if(distance > maxDistance) then
      agentVelocity.speed = maxDistance/dt
    else
      agentVelocity.speed = distance/dt
    end
  end
}

Actions.Idle = {
  name = "Idle",
  prerequisites = {},
  effects = {},
  perform = function(agent, target, dt)
    local agentVelocity = agent:get("Velocity")
    local agentPosition = agent:get("Position")

    local distance = agentVelocity.maxSpeed*dt -- distance the agent can walk
    local direction = (target:get("Position"):toVector() - agentPosition:toVector())
    local maxDistance = direction:len() - agent:get("Circle").radius - target:get("Circle").radius -- distance between agent and target
    direction:normalizeInplace()
    agentVelocity:setDirection(direction)

    if(distance > maxDistance) then
      agentVelocity.speed = maxDistance/dt
    else
      agentVelocity.speed = distance/dt
    end
  end
}

return Actions
