PhysicsSubsystem = Object:extend()

function PhysicsSubsystem:new()
end

function PhysicsSubsystem:update(game, dt)
  -- Update movable entities positions
  for _,e in pairs(game.movableEntities) do
    -- TODO: update velocities
    
    e.position = e.position + e.velocity * dt;
  end
end
