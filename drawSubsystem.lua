DrawSubsystem = Object:extend()

function DrawSubsystem:new()

end

function DrawSubsystem:draw(game)
  for _,e in ipairs(game.drawableEntities) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", e.position.x, e.position.y, e.radius)
  end
  self:drawPlayerHp(game.player)
end

function DrawSubsystem:drawPlayerHp(player)
  love.graphics.setNewFont(16)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 11, 11, 198*(player.hp/player.maxHp), 18)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", 10, 10, 200, 20)
  love.graphics.printf(string.format("%d/%d", player.hp, player.maxHp), 20, 12, 200, "center")
end

function DrawSubsystem:drawPlayerStats(player)
  --love.graphics.setNewFont(16)
  --love.graphics.printf( "Damage: %d", player.bulletDamage, 250, 12, 200, "left")
  --love.graphics.printf( "Attack Speed: " .. (1 / player.fireDelay), 250, 30, 200, "left")
  --love.graphics.printf( "Bullet Speed: " .. player.bulletSpeed, 500, 30, 200, "left")
  --love.graphics.printf( "Movement Speed: " .. player.speed, 500, 12, 200, "left")

end
