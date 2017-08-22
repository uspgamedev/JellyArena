MovementSubsystem = Object:extend()

function MovementSubsystem:new()
end

function MovementSubsystem:update(game, dt)
  -- Update movable entities positions
  for _,e in pairs(game.movableEntities) do
    -- TODO: update velocities

    e.position = e.position + e.velocity * dt;
    self.clampToStageBounds(e)
  end
end


function MovementSubsystem.clampToStageBounds(entity)
  -- TODO: get stage bounds instead of window bounds
  stage_width = love.graphics.getWidth() - entity.radius
  stage_height = love.graphics.getHeight() - entity.radius

  if entity.position.x < entity.radius then
    entity.position.x = entity.radius
  elseif entity.position.x > stage_width then
    entity.position.x = stage_width
  end

  if entity.position.y < entity.radius then
    entity.position.y = entity.radius
  elseif entity.position.y > stage_height then
    entity.position.y = stage_height
  end
end
