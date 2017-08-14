HUD = Object:extend()

function HUD:new()
  self.maxHp = 200
  self.hp = maxHp
end

function HUD:update(hp, maxHp)
  self.hp = hp
  self.maxHp = maxHp
end

function HUD:draw()
  love.graphics.setNewFont(16)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 11, 11, 198*(self.hp/self.maxHp), 18)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", 10, 10, 200, 20)
  love.graphics.printf( self.hp.."/"..self.maxHp, 20, 12, 200, "center")
end
