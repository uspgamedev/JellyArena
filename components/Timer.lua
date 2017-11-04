local Timer  = Component.create("Timer")

function Timer:initialize(waitTime, isActive)
  self.cooldown = waitTime
  self.waitTime = waitTime
  if not (isActive == nil)  then
    self.isActive = isActive
  else
    self.isActive = true
  end
end

function Timer:start ()
  self.cooldown = self.waitTime
  self.isActive = true
end

function Timer:setTime(waitTime)
  self.waitTime = waitTime
end
