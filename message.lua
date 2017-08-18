--Show game messsages to player
Message = Object:extend()

function Message:new()
  self.duration = 5
  self.text = ""
  self.event = function() end
end

function Message:update()
  self.event()
end

function Message:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setNewFont(30)
  love.graphics.printf(self.text, 0, love.graphics.getHeight()/6, love.graphics.getWidth(), "center")
end
