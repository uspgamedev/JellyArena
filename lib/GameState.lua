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
  getEngine():startSystem("CleanUpSystem")
end

local function stopIngameSystems()
  getEngine():stopSystem("TimerSystem")
  getEngine():stopSystem("EnemyAISystem")
  getEngine():stopSystem("MovementSystem")
  getEngine():stopSystem("CollisionSystem")
  getEngine():stopSystem("PlayerInputSystem")
  getEngine():stopSystem("WaveAISystem")
  getEngine():stopSystem("ProjectileSystem")
  getEngine():stopSystem("ProjectileSystem")
  getEngine():stopSystem("CleanUpSystem")
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
  local player = createPlayer(getCenter().x, getCenter().y)
  getEngine():addEntity(player)
  getEngine():addEntity(createPlayerAttack(player))
  getEngine():addEntity(createInvunerable(player))

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
