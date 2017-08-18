HUD = Object:extend()

function HUD:new()
end

function HUD:draw(game)
  self:drawPlayerStats(game.player)
  self:drawPlayerHp(game.player)

end

function HUD:drawPlayerHp(player)
  love.graphics.setNewFont(16)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 11, 11, 198*(player.hp/player.maxHp), 18)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", 10, 10, 200, 20)
  love.graphics.printf(player.hp .. "/" .. player.maxHp, 20, 12, 200, "center")
end

function HUD:drawPlayerStats(player)
  love.graphics.setNewFont(16)
  love.graphics.printf( "Movement Speed: " .. player.speed, 250, 12, 200, "left")
  love.graphics.printf( "Attack Speed: " .. (1 / player.fireDelay), 250, 30, 200, "left")
end
