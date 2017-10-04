local DrawMenuSystem = class("DrawMenuSystem", System)

background = { r = 0, g = 0, b  = 0}

function DrawMenuSystem:draw()
  local menu = getMenu()
  love.graphics.setColor(background.r, background.g, background.b, 200)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setNewFont(50)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf(menu.title, 0, 50, love.graphics.getWidth(), "center")
  love.graphics.setNewFont(20)
  for i, v in ipairs (menu.items) do
    love.graphics.printf(v.name, 0, 200 + i * 50, love.graphics.getWidth(), "center")
  end
  local highlight_width = string.len(menu.items[getSelectedItem()].name) * 15
  love.graphics.rectangle("line", getCenter().x - highlight_width/2, 185 + getSelectedItem() * 50, highlight_width, 50)
end



return DrawMenuSystem
