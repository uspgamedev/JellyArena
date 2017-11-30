local LifeTime = Component.create("LifeTime")

function LifeTime:initialize(waitTime, parent)
  self.cooldown = waitTime
  self.waitTime = waitTime
  self.isActive = true
  self.parent = parent
end

function LifeTime:start()
  self.cooldown = self.waitTime
  self.isActive = true
end

function LifeTime:kill()
  Utils.addGarbage(self.parent)
end
