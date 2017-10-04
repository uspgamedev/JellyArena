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
        name = "Options",
        action = function ()
          setMenu("options")
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
  },
  ["options"] = {
    title = "Options",
    items = {
      {
        name = "Music ON/OFF",
        action = function ()
          if play_track == true then
            play_track = false
            love.audio.stop()
          else
            play_track = true
          end
        end
      },
      {
        name = "Sound Effects ON/OFF",
        action = function ()
          if play_effects == true then
            play_effects = false
          else
            play_effects = true
          end
        end
      },
      {
        name = "Back",
        action = function ()
          setMenu("pause")
        end
      }
    }
  }
}

local selected_item = 1
local current_menu = menus["pause"]

function setMenu(menu_type)
  current_menu = menus[menu_type]
  selected_item = 1
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
