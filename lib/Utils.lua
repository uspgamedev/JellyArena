local Utils = {}

function Utils.getCenter()
  return {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function Utils.distToPix(distance)
  maxDist = Utils.getCenter().x
  return distance / 10 * maxDist
end

function Utils.getSound(filename)
  return "resources/sounds/"..filename
end

local engine

function Utils.getEngine()
  if engine == nil then
    engine = Engine()
  end
  return engine
end

function Utils.getChild(entity, label)
  for _, child in pairs(entity.children) do
    if (child:has("Label") and child:get("Label").label == label) then
      return child
    end
  end
  return nil
end

function Utils.getSpeed(movementSpeed)
  return 300 + movementSpeed * 20
end

function Utils.getShotRange(shotRange)
  return 150 + 10 * shotRange
end

function Utils.getShotDelay(shotSpeed)
  return 0.4 - 0.01 * shotSpeed
end

function Utils.getBulletSpeed(bulletSpeed)
  return 700 + 40 * bulletSpeed
end

return Utils
