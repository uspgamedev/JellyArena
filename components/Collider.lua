local Collider = Component.create("Collider")

function Collider:initialize(type, clampToStageBounds)
  -- TODO: move collision shape here
  self.type = type
  self.clampToStageBounds = clampToStageBounds
  self.resolved = false
  self.active = true
end
