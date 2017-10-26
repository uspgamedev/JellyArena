local Follow = Component.create("Follow")

-- target must be an entity with Position component
function Follow:initialize(target)
  self.target = target
end
