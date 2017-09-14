local Timer  = Component.create("Timer")

function Timer:initialize(waitTime)
  self.cooldown = waitTime
  self.waitTime = waitTime
  self.isActive = true
end

function Timer:start ()
  self.cooldown = self.waitTime
  self.isActive = true
end
