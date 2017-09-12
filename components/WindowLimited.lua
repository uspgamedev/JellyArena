local WindowLimited = Component.create("WindowLimited")

function WindowLimited:initialize(entity, callback)
  self.callback = callback or function () end
  self.entity = entity
end

function WindowLimited:collide()
  self.callback(self.entity)
end
