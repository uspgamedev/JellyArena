local Animation = Component.create("Animation")

function Animation:initialize(spriteImage, keyframes, frameTime, rotationSpeed)
  self.time = 0
  self.spriteImage = spriteImage
  self.curFrame = 1
  self.keyframes = keyframes
  self.frameTime = frameTime -- time for each frame in ms
  self.maxFrames = #keyframes
  self.rotationSpeed = (rotationSpeed or 0)
  self.rotation = 0;
end

function Animation:changeFrame()  
  self.curFrame = self.curFrame + 1
  self.time = self.time - self.frameTime -- try to keep animation stable regardless of FPS

  if(self.curFrame > self.maxFrames) then
    -- TODO: signal End of animation
    self.curFrame = 1
  end
end

function Animation:update(dt)
  self.rotation = self.rotation + self.rotationSpeed * dt;
  if(self.rotation > 2 * math.pi) then
    self.rotation = self.rotation - 2 * math.pi;
  end
  self.time = self.time + dt;
  if(self.time >= self.frameTime) then
    self:changeFrame(); 
  end
end

function Animation:getSprite()
  return self.spriteImage, self.keyframes[self.curFrame];
end

function Animation:changeFrameTime(newTime)
  self.frameTime = newTime;

  if(self.time >= newTime) then
    self:changeFrame();
    self.time = 0;
  end
end
