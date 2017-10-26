local stats_points = 10

function getStatsPoints()
  return stats_points
end

function getPlayer()
  p = getEngine():getEntitiesWithComponent("IsPlayer")
  for _, player in pairs(p) do
    return player
  end
end

function getStats()
  if getPlayer() ~= nil then
    return getPlayer():get("Stats")
  end
  return {damage = 2, movement_speed = 10, shot_speed = 20, bullet_speed = 10, shot_range = 10}
end

function increaseStat(stat, value)
  local stats = getStats()
  if (stats_points > 0) then
    if (stat == "damage") then
      stats.damage = stats.damage + value
    elseif (stat == "movement_speed") then
      stats.movement_speed = stats.movement_speed + value
    elseif (stat == "shot_speed") then
      stats.shot_speed = stats.shot_speed + value
    elseif (stat == "bullet_speed") then
      stats.bullet_speed = stats.bullet_speed + value
    elseif (stat == "shot_range") then
      stats.shot_range = stats.shot_range + value
    end
    stats_points = stats_points - 1
  end
end

function restartGame()
  for _, entity in pairs(getEngine().entities) do
    getEngine():removeEntity(entity, true)
  end

  local player = createPlayer(500, 500)
  local pos = player:get("Position")
  camera = Camera(pos.x, pos.y)
  getEngine():addEntity(player)
  getEngine():addEntity(createPlayerAttack(player))
  getEngine():addEntity(createInvunerable(player))

  changeGameState(GameStates.ingame)
end

local menus = {
  ["pause"] = {
    title = "Pause",
    align = "center",
    items = {
      {
        name = "Resume",
        action = function()
          changeGameState(GameStates.ingame)
        end
      },
      {
        name = "Restart",
        action = restartGame
      },
      {
        name = "Upgrade Stats",
        action = function()
          updateStatsValues()
          setMenu("stats")
        end
      },
      {
        name = "Options",
        action = function()
          setMenu("options")
        end
      },
      {
        name = "Exit",
        action = function()
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
        action = function()
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
        action = function()
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
        action = function()
          if play_effects == true then
            play_effects = false
          else
            play_effects = true
          end
        end
      },
      {
        name = "Back",
        action = function()
          setMenu("pause")
        end
      }
    }
  },
  ["stats"] = {
    title = "Upgrade Stats",
    align = "left",
    info = "Points remaining: " .. getStatsPoints(),
    items = {
      {
        name = "Damage: " .. getStats().damage,
        action = function()
          increaseStat("damage", 1)
          updateStatsValues()
        end
      },
      {
        name = "Movement Speed: " .. getStats().movement_speed,
        action = function()
          increaseStat("movement_speed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Shot Speed: " .. getStats().shot_speed,
        action = function()
          increaseStat("shot_speed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Bullet Speed: " .. getStats().bullet_speed,
        action = function()
          increaseStat("bullet_speed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Shot Range{damage  = 10, movement_speed = 20, shot_speed = 10, bullet_speed = 10, shot_range = 10}: " ..
          getStats().shot_range,
        action = function()
          increaseStat("shot_range", 1)
          updateStatsValues()
        end
      },
      {
        name = "Back",
        action = function()
          setMenu("pause")
        end
      }
    }
  }
}

function updateMenuStats()
  menus["stats"].info = "Points remaining: " .. getStatsPoints()
  menus["stats"].items[1].name = "Damage: " .. getStats().damage
  menus["stats"].items[2].name = "Movement Speed: " .. getStats().movement_speed
  menus["stats"].items[3].name = "Shot Speed: " .. getStats().shot_speed
  menus["stats"].items[4].name = "Bullet Speed: " .. getStats().bullet_speed
  menus["stats"].items[5].name = "Shot Range: " .. getStats().shot_range
end

function updatePlayerStats()
  getPlayer():get("Velocity").speed = 300 + 20 * getStats().movement_speed
end

function updateStatsValues()
  updateMenuStats()
  updatePlayerStats()
end

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
