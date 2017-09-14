local Collider = Component.create("Collider")

function Collider:initialize(clampToStageBounds)
  -- TODO: move collision shape here
  self.clampToStageBounds = clampToStageBounds
  self.resolved = false
  self.active = true
end