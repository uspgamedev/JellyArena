function getCenter()
  return {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function distToPix(distance)
  maxDist = getCenter().x
  return distance / 10 * maxDist
end

function getSound(file_name)
  return "resources/sounds/"..file_name
end

local engine

function getEngine()
  if engine == nil then
    engine = Engine()
  end
  return engine
end

function getChild(entity, label)
  for _, child in pairs(entity.children) do
    if (child:has("Label") and child:get("Label").label == label) then
      return child
    end
  end
  return nil
end

function getSpeed(movement_speed)
  return 160 + movement_speed * 30
end

function getShotRange(shot_range)
  return 150 + 10 * shot_range
end

function getShotDelay(shot_speed)
  return 0.4 - 0.01 * shot_speed
end

function getBulletSpeed(bullet_speed)
  return 700 + 40 * bullet_speed
end
