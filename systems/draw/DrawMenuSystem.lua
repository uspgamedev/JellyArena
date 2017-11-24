local DrawMenuSystem = class("DrawMenuSystem", System)

local background = {r = 0, g = 0, b = 0}

function DrawMenuSystem:draw()
  local menu = MenuController.getMenu()
  love.graphics.setColor(background.r, background.g, background.b, 200)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setFont(Utils.defaultFont(), 50)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf(menu.title, 0, 50, love.graphics.getWidth(), "center")

  love.graphics.setFont(Utils.defaultFont(), 20)
  local textWidth
  local textX
  love.graphics.setColor(255, 255, 0, 255)
  if (menu.info ~= nil) then
    love.graphics.printf(menu.info, 100, 200, 300, "left")
  end
  love.graphics.setColor(255, 255, 255, 255)
  for i, v in ipairs(menu.items) do
    textWidth = love.graphics.getFont():getWidth(v.name)
    if (MenuController.getMenu().align == "center") then
      textX = Utils.getCenter().x - textWidth / 2
    elseif (MenuController.getMenu().align == "left") then
      textX = 100
    end
    love.graphics.printf(v.name, textX, 208 + i * 50, textWidth, "center")
  end

  local highlightWidth = love.graphics.getFont():getWidth(menu.items[MenuController.getSelectedItem()].name)
  local highlightX
  if (MenuController.getMenu().align == "center") then
    highlightX = Utils.getCenter().x - highlightWidth / 2 - 20
  elseif (MenuController.getMenu().align == "left") then
    highlightX = 80
  end
  if not MenuController.getMenu().hideSelector then
    love.graphics.circle("fill", highlightX, 210 + MenuController.getSelectedItem() * 50, 10)
  end
end

return DrawMenuSystem
