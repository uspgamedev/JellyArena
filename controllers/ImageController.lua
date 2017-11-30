local ImageController = { }
local Images = {}
local loaded = false

function ImageController.load()
  if loaded then
    return
  end

  local filenames = {"map", "jello", "charger", "shooter"}
  local basePath = "resources/images/"
  for _, filename in pairs(filenames) do
    Images[filename] = love.graphics.newImage(basePath..filename..".png" )
  end

  loaded = true
end

function ImageController.getImage(name)
  return Images[name]
end

function ImageController.getAnimation(name, frameCount, frameTime)
  local spriteSheet = Images[name]
  local keyframes = {}
  for i=1,frameCount do
    keyframes[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, spriteSheet:getDimensions())
  end
  local animationMetadata = {spriteSheet, keyframes, frameTime}
  
  return spriteSheet, keyframes, frameTime
end

return ImageController
