local MenuController = {}
local menus = {}

local function getPlayer()
  p = Utils.getEngine():getEntitiesWithComponent("IsPlayer")
  for _, player in pairs(p) do
    return player
  end
end

local function getStats()
  if getPlayer() then
    return getPlayer():get("Stats")
  end
  return {damage = 2, movementSpeed = 10, shotSpeed = 20, bulletSpeed = 10, shotRange = 10}
end

local function getStatsPoints()
  if getPlayer() then
    return getPlayer():get("RemainingPoints").remaining
  end
  return 0
end

local function increaseStat(stat, value)
  local stats = getStats()
  local statsPoint = getPlayer():get("RemainingPoints")
  if (statsPoint.remaining - value >= 0) then
    if (stat == "damage") then
      stats.damage = stats.damage + value
    elseif (stat == "movementSpeed") then
      stats.movementSpeed = stats.movementSpeed + value
    elseif (stat == "shotSpeed") then
      stats.shotSpeed = stats.shotSpeed + value
    elseif (stat == "bulletSpeed") then
      stats.bulletSpeed = stats.bulletSpeed + value
    elseif (stat == "shotRange") then
      stats.shotRange = stats.shotRange + value
    end
    statsPoint.remaining = statsPoint.remaining - value
  end
end

function restartGame()
  GameState.changeGameState("startingGame")
end

local function updateMenuStats()
  menus["stats"].info = "Points remaining: " .. getStatsPoints()
  menus["stats"].items[1].name = "Damage: " .. getStats().damage
  menus["stats"].items[2].name = "Movement Speed: " .. getStats().movementSpeed
  menus["stats"].items[3].name = "Shot Speed: " .. getStats().shotSpeed
  menus["stats"].items[4].name = "Bullet Speed: " .. getStats().bulletSpeed
  menus["stats"].items[5].name = "Shot Range: " .. getStats().shotRange
end

local function updatePlayerStats()
  -- update Movement Speed
  getPlayer():get("Velocity").speed = Utils.getSpeed(getStats().movementSpeed)

  local attack
  for _, child in pairs(getPlayer().children) do
    if child:has("AttackProperties") then
      attack = child
    end
  end
  -- update Shot Speed
  attack:get("Timer"):setTime(Utils.getShotDelay(getStats().shotSpeed))
  -- update Shot Range
  attack:get("AttackRange"):setRange(Utils.getShotRange(getStats().shotRange))
end

local function updateStatsValues()
  updateMenuStats()
  updatePlayerStats()
end

local selectedItem = 1
local currentMenu = menus["pause"]

menus = {
  ["pause"] = {
    title = "Pause",
    align = "center",
    items = {
      {
        name = "Resume",
        action = function()
          GameState.changeGameState(GameState.popGameState())
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
          MenuController.setMenu("stats")
        end
      },
      {
        name = "Options",
        action = function()
          MenuController.setMenu("options")
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
          if SoundController.isMusicOn then
            SoundController.isMusicOn = false
            love.audio.stop()
          else
            SoundController.isMusicOn = true
          end
        end
      },
      {
        name = "Sound Effects ON/OFF",
        action = function()
          if SoundController.isEffectOn then
            SoundController.isEffectOn = false
          else
            SoundController.isEffectOn = true
          end
        end
      },
      {
        name = "Back",
        action = function()
          MenuController.setMenu("pause")
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
        name = "Movement Speed: " .. getStats().movementSpeed,
        action = function()
          increaseStat("movementSpeed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Shot Speed: " .. getStats().shotSpeed,
        action = function()
          increaseStat("shotSpeed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Bullet Speed: " .. getStats().bulletSpeed,
        action = function()
          increaseStat("bulletSpeed", 1)
          updateStatsValues()
        end
      },
      {
        name = "Shot Range{damage  = 10, movementSpeed = 20, shotSpeed = 10, bulletSpeed = 10, shotRange = 10}: " ..
          getStats().shotRange,
        action = function()
          increaseStat("shotRange", 1)
          updateStatsValues()
        end
      },
      {
        name = "Back",
        action = function()
          MenuController.setMenu("pause")
        end
      }
    }
  }
}

function MenuController.setMenu(menuType)
  currentMenu = menus[menuType]
  selectedItem = 1
end

function MenuController.getMenu()
  return currentMenu
end

function MenuController.previousMenuItem()
  if selectedItem > 1 then
    selectedItem = selectedItem - 1
  end
end

function MenuController.nextMenuItem()
  if selectedItem < #currentMenu.items then
    selectedItem = selectedItem + 1
  end
end

function MenuController.getSelectedItem()
  return selectedItem
end

function MenuController.selectMenuitem()
  currentMenu.items[selectedItem].action()
end

return MenuController
