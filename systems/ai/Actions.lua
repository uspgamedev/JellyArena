local Actions = {}

Actions.MeleeAttack = {
  prerequisites = {
    {
      name = "InRange",
      target = "Player",
    },
    {
      name = "AttackAvailable"
    }
  },
  effects = {
    {
      name = "Damage"
    }
  },
  perform = function(agent, target, dt)
    local attackTimer = agent:get("Timer")
    local damage = createDamage(agent)
    engine:addEntity(damage)
    table.insert(garbage_list, damage)
    attackTimer:start()
  end
}

Actions.FollowPlayer = {
  prerequisites = {
  },
  effects = {
    {
      name = "InRange",
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
