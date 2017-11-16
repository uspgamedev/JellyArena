local ImageController = { }
local Images = {}
local loaded = false

function ImageController.load()
  if loaded then
    return
  end

  local filenames = {"map"}
  local basePath = "resources/images/"
  for _, filename in pairs(filenames) do
    Images[filename] = love.graphics.newImage(basePath..filename..".png" )
  end

  loaded = true
end

function ImageController.getImage(name)
  return Images[name]
end

return ImageController
