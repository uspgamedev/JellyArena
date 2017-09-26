local CleanUpSystem = class("CleanUpSystem", System)

function CleanUpSystem:update(dt)
  for _, target in pairs(garbage_list) do
    engine:removeEntity(target)
  end
  garbage_list = {}
end

function CleanUpSystem:requires()
  return {}
end

return CleanUpSystem
