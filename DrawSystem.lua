local DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
    for i, v in pairs(self.targets) do
        local position = v:get("Position")
        local circle = v:get("Circle")
        love.graphics.setColor(255, 150, 0)
        love.graphics.circle("fill", position.x, position.y, circle.radius)
    end
end

function DrawSystem:requires()
    return {"Position", "Circle"}
end

return DrawSystem
