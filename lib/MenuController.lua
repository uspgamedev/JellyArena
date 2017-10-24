function restartGame()
  for _, entity in pairs(engine.entities) do
    engine:removeEntity(entity, true)
  end

  local player = createPlayer(500, 500)
  local pos = player:get("Position")
  camera = Camera(pos.x, pos.y)
  engine:addEntity(player)
  engine:addEntity(createPlayerAttack(player))
  engine:addEntity(createInvunerable(player))

  changeGameState(GameStates.ingame)
end

local menus = {
  ["pause"] = {
    title = "Pause",
    align = "center",
    items = {
      {
        name = "Resume",
        action = function ()
          changeGameState(GameStates.ingame)
        end
      },
      {
        name = "Restart",
        action = restartGame
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
    align = "center",
    items = {
      {
        name = "Restart",
        action = restartGame
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
    align = "center",
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
  },
  ["status"] = {
    title = "Upgrade Stats",
    align = "left",
    items = {
      {
        name = "Damage:",
        action = function () end
      },
      {
        name = "Movement Speed:",
        action = function () end
      },
      {
        name = "Shot Speed:",
        action = function () end
      },
      {
        name = "Bullet Speed:",
        action = function () end
      },
      {
        name = "Back:",
        action = function () end
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
