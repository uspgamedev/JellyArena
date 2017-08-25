local HudDrawSystem = class("HudDrawSystem", System)

function HudDrawSystem:draw()
  for i, v in pairs(self.targets) do
    local combat = v:get("Combat")
    love.graphics.setNewFont(16)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 11, 11, 198*(combat.hp/combat.maxHp), 18)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", 10, 10, 200, 20)
    love.graphics.printf(string.format("%d/%d", combat.hp, combat.maxHp), 20, 12, 200, "center")
  end
end

function HudDrawSystem:requires()
  return {"IsPlayer", "Combat"}
end

return HudDrawSystem
