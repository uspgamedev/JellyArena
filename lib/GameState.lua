GameData = {}

local GameStates = {
  startingGame = {
    systems = {},
    onResume = function()
      GameData = {}
      garbage_list = {}
      WaveController.createLearningList()
      Statistic.reset()

      for _, entity in pairs(getEngine().entities) do
        getEngine():removeEntity(entity, true)
      end

      local player = createPlayer(500, 500)
      local pos = player:get("Position")
      camera = Camera(pos.x, pos.y)
      getEngine():addEntity(player)
      getEngine():addEntity(createPlayerAttack(player))
      getEngine():addEntity(createInvunerable(player))

      changeGameState("waitingWave")
    end,
    onPause = function() end
  },
  waitingWave = {
    systems = {
      "TimerSystem",
      "MovementSystem",
      "CollisionSystem",
      "PlayerInputSystem",
      "ProjectileSystem",
      "CleanUpSystem",
      "DrawSystem",
      "DrawHUDSystem",
      "WaveAISystem"
    },
    onResume = function() end,
    onPause = function() end
  },
  ingame = {
    systems = {
      "TimerSystem",
      "EnemyAISystem",
      "MovementSystem",
      "CollisionSystem",
      "PlayerInputSystem",
      "WaveAISystem",
      "ProjectileSystem",
      "CleanUpSystem",
      "DrawSystem",
      "DrawHUDSystem"
    },
    onResume = function() end,
    onPause = function() end
  },
  pauseMenu = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem",
      "DrawSystem",
      "DrawHUDSystem"
    },
    onResume = function(previousState)
      pushGameState(previousState)
      setMenu("pause")
    end,
    onPause = function() end
  },
  gameOver = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem",
      "DrawSystem",
      "DrawHUDSystem"
    },
    onResume = function() setMenu("gameOver") end,
    onPause = function() end
  }
}

local StateStackSize = 0
local StateStack = {}

function pushGameState(state)
  StateStack[StateStackSize] = state
  StateStackSize = StateStackSize + 1
end

function popGameState()
  if(StateStackSize == 0) then
    return nil
  end
  local state = StateStack[StateStackSize-1]
  StateStack[StateStackSize-1] = nil
  StateStackSize = StateStackSize - 1
  return state
end

function changeGameState(state)
  local curStateData = GameStates[curGameState] or {
    systems = {},
    onResume = function() end,
    onPause = function() end
  }

  local newStateData = GameStates[state]
  if not newStateData then
    error("Invalid State")
    return
  end

  for _, state in pairs(curStateData.systems) do
    if not containsValue(newStateData.systems, state) then
      getEngine():stopSystem(state)
    end
  end

  for _, state in pairs(newStateData.systems) do
    if not containsValue(curStateData.systems, state) then
      getEngine():startSystem(state)
    end
  end

  previousState = curGameState
  curGameState = state
  curStateData.onPause(curGameState)
  newStateData.onResume(previousState)

end
