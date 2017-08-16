HUD = Object:extend()

function HUD:new()
end

function HUD:draw(player)
  love.graphics.setNewFont(16)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 11, 11, 198*(player.hp/player.maxHp), 18)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", 10, 10, 200, 20)
  love.graphics.printf( player.hp .. "/" .. player.maxHp, 20, 12, 200, "center")
end
