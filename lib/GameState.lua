local GameState = {}

local StateStackSize = 0
local StateStack = {}

local function pushGameState(state)
  StateStack[StateStackSize] = state
  StateStackSize = StateStackSize + 1
end

GameState.GameData = {}

local GameStates = {
  startingGame = {
    systems = {},
    onResume = function()
      SoundController.setTrack("waves")
      SoundController.playTrack()
      GameState.GameData = {}
      garbageList = {}
      WaveController.createLearningList()
      StatisticController.reset()
      ImageController.load()

      local engine = Utils.getEngine()
      for _, entity in pairs(engine.entities) do
        engine:removeEntity(entity, true)
      end
      local mapSize = Utils.mapDefinitions
      local player = createPlayer(mapSize.width/2, mapSize.height/2)
      local pos = player:get("Position")
      camera = Camera(pos.x, pos.y, 0.75)
      engine:getSystem("WaveAISystem"):reset()
      engine:addEntity(player)
      engine:addEntity(createPlayerAttack(player))
      engine:addEntity(createInvunerable(player))

      GameState.changeGameState("waitingWave")
    end,
    onPause = function()
    end
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
      "WaveAISystem",
      "AnimationSystem"
    },
    onResume = function()
      Utils.getEngine():getSystem("CollisionSystem"):reset()
    end,
    onPause = function()
    end,
    keyPressed = function(key)
      if (key == "escape") then
        GameState.changeGameState("pauseMenu")
      end
    end
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
      "DrawHUDSystem",
      "AnimationSystem"
    },
    onResume = function()
    end,
    onPause = function()
    end,
    keyPressed = function(key)
      if (key == "escape") then
        GameState.changeGameState("pauseMenu")
      end
    end
  },
  startMenu = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem",
    },
    onResume = function(previousState)
      pushGameState(previousState)
      MenuController.setMenu("start")
      SoundController.setTrack("menu")
    end,
    onPause = function()
    end
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
      MenuController.setMenu("pause")
    end,
    onPause = function()
    end,
    keyPressed = function(key)
      if (key == "escape") then
        GameState.changeGameState(GameState.popGameState())
      end
    end
  },
  gameOver = {
    systems = {
      "MenuInputSystem",
      "DrawMenuSystem",
      "DrawSystem",
      "DrawHUDSystem"
    },
    onResume = function()
      MenuController.setMenu("gameOver")
      SoundController.setLooping(false)
      SoundController.setTrack("gameover")
    end,
    onPause = function()
      SoundController.setLooping(true)
    end
  }
}

function GameState.popGameState()
  if (StateStackSize == 0) then
    return nil
  end
  local state = StateStack[StateStackSize - 1]
  StateStack[StateStackSize - 1] = nil
  StateStackSize = StateStackSize - 1
  return state
end

function GameState.changeGameState(state)
  local curStateData =
    GameStates[curGameState] or
    {
      systems = {},
      onResume = function()
      end,
      onPause = function()
      end
    }

  local newStateData = GameStates[state]
  if not newStateData then
    error("Invalid State")
    return
  end

  local engine = Utils.getEngine()
  for _, state in pairs(curStateData.systems) do
    if not Utils.containsValue(newStateData.systems, state) then
      engine:stopSystem(state)
    end
  end

  for _, state in pairs(newStateData.systems) do
    if not Utils.containsValue(curStateData.systems, state) then
      engine:startSystem(state)
    end
  end

  previousState = curGameState
  curGameState = state
  curStateData.onPause(curGameState)
  newStateData.onResume(previousState)
end

function GameState.keyPressed(key)
  callback = GameStates[curGameState].keyPressed
  print(callback ~= nil)
  if callback ~= nil then
    callback(key)
  end
end

return GameState
