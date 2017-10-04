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
  local text_width
  local text_x
  for i, v in ipairs (menu.items) do
    text_width = love.graphics.getFont():getWidth(v.name)
    if ( getMenu().align == "center" ) then
      text_x = getCenter().x - text_width/2
    elseif ( getMenu().align == "left" ) then
      text_x = 100
    end
    love.graphics.printf(v.name, text_x , 200 + i * 50, text_width, "center")
  end

  local highlight_width = love.graphics.getFont():getWidth(menu.items[getSelectedItem()].name)
  local highlight_x
  if ( getMenu().align == "center" ) then
    highlight_x = getCenter().x - highlight_width/2 - 20
  elseif ( getMenu().align == "left" ) then
    highlight_x = 80
  end
  --love.graphics.rectangle("line", getCenter().x - highlight_width/2, 185 + getSelectedItem() * 50, highlight_width, 50)
  love.graphics.circle("fill", highlight_x , 210 + getSelectedItem() * 50, 10)
end



return DrawMenuSystem
