local DrawHUDSystem = class("DrawHUDSystem", System)

function DrawHUDSystem:draw()
  for i, v in pairs(self.targets.player) do
    local hp = v:get("Hitpoints")
    local timer = v:get("Timer")
    love.graphics.setNewFont(16)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 11, 11, 198*(hp.cur/hp.max), 18)

    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", 591, 11, 198 - 198*(timer.cooldown/timer.waitTime), 18)

    love.graphics.setColor(245, 245, 245)
    love.graphics.rectangle("line", 10, 10, 200, 20)
    love.graphics.rectangle("line", 590, 10, 200, 20)
    love.graphics.printf(string.format("%d/%d", hp.cur, hp.max), 20, 12, 200, "center")
    if ( timer.cooldown <= 0 ) then
      love.graphics.setColor(255, 255, 0)
      love.graphics.printf("Charged!", 600, 12, 200, "center")
    end
  end

  -- debug
  love.graphics.setColor(255, 255, 255)
  if curGameState == "waitingWave" then
    nextWave = (GameState.GameData.waveNumber or 0) + 1
    waveInfo = string.format("Wave %d starting in %d second(s)", nextWave, GameState.GameData.waveWaitTime+0.5)
  elseif curGameState == "ingame" then
    waveInfo = string.format("Wave %d", GameState.GameData.waveNumber)
  end
  love.graphics.printf(waveInfo, 12, 560, 250, "center")
  love.graphics.printf(string.format("%d spawned enemies", Utils.count(self.targets.enemies)), 600, 560, 200, "center")
end

function DrawHUDSystem:requires()
  return {player = {"IsPlayer", "Hitpoints"}, enemies = {"AI"}}
end

return DrawHUDSystem
