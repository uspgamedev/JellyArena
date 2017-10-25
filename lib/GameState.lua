GameStates = {
  ingame    = {},
  newGame   = {},
  pauseMenu  = {},
  gameOver  = {}
}


------------- Auxiliary functions -------------
local function startIngameSystems()
  getEngine():startSystem("TimerSystem")
  getEngine():startSystem("EnemyAISystem")
  getEngine():startSystem("MovementSystem")
  getEngine():startSystem("CollisionSystem")
  getEngine():startSystem("PlayerInputSystem")
  getEngine():startSystem("WaveAISystem")
  getEngine():startSystem("ProjectileSystem")
end

local function stopIngameSystems()
  getEngine():stopSystem("TimerSystem")
  getEngine():stopSystem("EnemyAISystem")
  getEngine():stopSystem("MovementSystem")
  getEngine():stopSystem("CollisionSystem")
  getEngine():stopSystem("PlayerInputSystem")
  getEngine():stopSystem("WaveAISystem")
  getEngine():stopSystem("ProjectileSystem")
end

local function stopMenuSystems()
  getEngine():stopSystem("MenuInputSystem")
  getEngine():stopSystem("DrawMenuSystem")
end
-----------------------------------------------
---------- State creation funcitons -----------
local function setIngameState()
  startIngameSystems()
  stopMenuSystems()
end

local function setNewGameState()
  getEngine():addEntity(createPlayer(getCenter().x, getCenter().y))

  setIngameState()
  curGameState = GameStates.ingame
end

local function setPauseMenuState()
  stopIngameSystems()
  setMenu("pause")
  getEngine():startSystem("MenuInputSystem")
  getEngine():startSystem("DrawMenuSystem")
end

local function setGameOverState()
  stopIngameSystems()
  setMenu("gameOver")
  getEngine():startSystem("MenuInputSystem")
  getEngine():startSystem("DrawMenuSystem")
end

function changeGameState(gameState)
  curGameState = gameState

  if(gameState == GameStates.ingame) then setIngameState()
  elseif(gameState == GameStates.newGame) then setNewGameState()
  elseif(gameState == GameStates.pauseMenu) then setPauseMenuState()
  elseif(gameState == GameStates.gameOver) then setGameOverState()
  end
end
