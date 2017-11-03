local CleanUpSystem = class("CleanUpSystem", System)

function CleanUpSystem:update(dt)
  for _, target in pairs(garbageList) do
    Utils.getEngine():removeEntity(target)
  end
  garbageList = {}
end

function CleanUpSystem:requires()
  return {}
end

return CleanUpSystem
