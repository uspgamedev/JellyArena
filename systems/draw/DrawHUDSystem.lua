local DrawHUDSystem = class("DrawHUDSystem", System)

function DrawHUDSystem:draw()
  for i, v in pairs(self.targets.player) do
    local hp = v:get("Hitpoints")
    love.graphics.setNewFont(16)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 11, 11, 198*(hp.cur/hp.max), 18)
    love.graphics.setColor(245, 245, 245)
    love.graphics.rectangle("line", 10, 10, 200, 20)
    love.graphics.printf(string.format("%d/%d", hp.cur, hp.max), 20, 12, 200, "center")
  end

  -- debug
  if curGameState == "waitingWave" then
    nextWave = (GameData.waveNumber or 0) + 1
    waveInfo = string.format("Waiting wave %d", nextWave)
  elseif curGameState == "ingame" then
    waveInfo = string.format("Wave %d", GameData.waveNumber)
  end
  love.graphics.printf(waveInfo, 300, 12, 200, "center")
  love.graphics.printf(string.format("%d spawned enemies", count(self.targets.enemies)), 600, 12, 200, "center")
end

function DrawHUDSystem:requires()
  return {player = {"IsPlayer", "Hitpoints"}, enemies = {"AI"}}
end

return DrawHUDSystem
