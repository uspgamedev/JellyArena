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
