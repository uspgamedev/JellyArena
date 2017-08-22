MovementSubsystem = Object:extend()

function MovementSubsystem:new()
end

function MovementSubsystem:update(game, dt)
  -- Update movable entities positions
  for _,e in pairs(game.movableEntities) do
    -- TODO: update velocities

    e.position = e.position + e.velocity * dt;
  end
end
