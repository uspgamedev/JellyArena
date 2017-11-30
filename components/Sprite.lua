local Animation = Component.create("Animation")

function Animation:initialize(spriteImage, keyframes, frameTime)

  self.time = 0
  self.spriteImage = spriteImage
  self.curFrame = 1
  self.keyframes = keyframes
  self.frameTime = frameTime -- time for each frame in ms
  self.maxFrames = #keyframes
end

function Animation:changeFrame()  
  self.curFrame = self.curFrame + 1
  self.time = self.time - self.frameTime -- try to keep animation stable regardless of FPS

  if(self.curFrame == self.maxFrames) then
    -- TODO: signal End of animation
    self.curFrame = 1
  end
end

function Animation:getSprite(dt)  
  self.time = self.time + dt;
  if(self.time >= self.frameTime) then
    changeFrame(); 
  end
  return keyframe[curSprite];
end

function Animation:changeFrameTime(newTime)
  self.frameTime = newTime;

  if(self.time >= newTime) then
    changeFrame();
    self.time = 0;
  end
end
