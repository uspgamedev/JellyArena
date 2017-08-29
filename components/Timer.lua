local Timer  = Component.create("Timer")

function Timer:initialize(waitTime)
  self.cooldown = waitTime
  self.waitTime = waitTime
  self.isActive = false
end
