local ImageController = { }
local Images = {}
local loaded = false

function ImageController.load()
  if loaded then
    return
  end

  local filenames = {"map", "jello", "charger", "shooter", "bullet", "health", "pushTrap", "damageTrap", "dummy"}
  local basePath = "resources/images/"
  for _, filename in pairs(filenames) do
    Images[filename] = love.graphics.newImage(basePath..filename..".png" )
  end

  --TODO: change to proper boss animation
  Images["boss"] = Images["charger"]

  --TODO: change to proper hybrid animation
  Images["hybrid"] = Images["shooter"]

  loaded = true
end

function ImageController.getImage(name)
  return Images[name]
end

function ImageController.getAnimation(name, frameCount, frameTime, spriteSize, rotationSpeed)
  spriteSize = spriteSize or 32
  rotationSpeed = rotationSpeed or 0
  
  local spriteSheet = Images[name]
  local keyframes = {}
  
  for i=1,frameCount do
    keyframes[i] = love.graphics.newQuad((i - 1) * spriteSize, 0, spriteSize, spriteSize, spriteSheet:getDimensions())
  end

  return spriteSheet, keyframes, frameTime, rotationSpeed
end

return ImageController
