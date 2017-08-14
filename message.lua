--Show game messsages to player
Message = Object:extend()

function Message:new()
  self.duration = 5
  self.text = ""
end

function Message:update(dt)

end

function Message:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setNewFont(20)
  love.graphics.printf(self.text, 200, 100, 400, "center")
end
