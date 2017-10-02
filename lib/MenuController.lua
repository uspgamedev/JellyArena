local menus = {
  ["pause"] = {
    title = "Pause",
    items = {
      {
        name = "Resume",
        action = function ()
          changeGameState(GameStates.ingame)
        end
      },
      {
        name = "Options",
        action = function ()
        end
      },
      {
        name = "Exit",
        action = function ()
          love.event.quit(0)
        end
      }
    }
  },
  ["gameOver"] = {
    title = "Game Over",
    items = {
      {
        name = "Restart",
        action = function ()
          for _, entity in pairs(engine.entities) do
            engine:removeEntity(entity, true)
          end

          engine:addEntity(createPlayer(getCenter().x, getCenter().y))

          changeGameState(GameStates.ingame)
        end
      },
      {
        name = "Exit",
        action = function ()
          love.event.quit(0)
        end
      }
    }
  }
}

local selected_item = 1
local current_menu = menus["pause"]

function setMenu(menu_type)
  current_menu = menus[menu_type]
end

function getMenu()
  return current_menu
end

function previousMenuItem()
  if selected_item > 1 then
    selected_item = selected_item - 1
  end
end

function nextMenuItem()
  if selected_item < #current_menu.items then
    selected_item = selected_item + 1
  end
end

function getSelectedItem()
  return selected_item
end

function selectMenuitem()
  current_menu.items[selected_item].action()
end
