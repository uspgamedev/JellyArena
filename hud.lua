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
  love.graphics.printf( "Movement Speed: " .. player.movementSpeed, 250, 12, 200, "left")
  love.graphics.printf( "Attack Speed: " .. player.attackSpeed, 250, 30, 200, "left")
end
