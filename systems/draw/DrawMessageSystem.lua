local DrawMessageSystem = class("DrawMessageSystem", System)

function DrawMessageSystem:draw()
    love.graphics.setColor(255,255,255,255)
    love.graphics.setNewFont(20)
    love.graphics.printf(debug_text, 0, 100, love.graphics.getWidth(), "center")
end

return DrawMessageSystem
