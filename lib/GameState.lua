GameStates = {
  waitingWave = {
    systems = {
      "TimerSystem",
      "MovementSystem",
      "CollisionSystem",
      "PlayerInputSystem",
      "ProjectileSystem",
      "CleanUpSystem"
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
      "CleanUpSystem"
    },
    onResume = function() end,
    onPause = function() end
  },
  pauseMenu = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem"
    },
    onResume = function() setMenu("pause") end,
    onPause = function() end
  },
  gameOver = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem"
    },
    onResume = function() setMenu("gameOver") end,
    onPause = function() end
  }
}

function changeGameState(state)
  curStateData = GameStates[curGameState]
  newStateData = GameStates[state]
  if not newStateData then
    print "Invalid State, aborting"
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

  curGameState = state
  curStateData.onPause()
  newStateData.onResume()
end
