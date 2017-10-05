GameStates = {
  ingame    = {},
  newGame   = {},
  pauseMenu  = {},
  gameOver  = {}
}


------------- Auxiliary functions -------------
local function startIngameSystems()
  engine:startSystem("TimerSystem")
  engine:startSystem("EnemyAISystem")
  engine:startSystem("MovementSystem")
  engine:startSystem("CollisionSystem")
  engine:startSystem("PlayerInputSystem")
  engine:startSystem("WaveAISystem")
  engine:startSystem("ProjectileSystem")
end

local function stopIngameSystems()
  engine:stopSystem("TimerSystem")
  engine:stopSystem("EnemyAISystem")
  engine:stopSystem("MovementSystem")
  engine:stopSystem("CollisionSystem")
  engine:stopSystem("PlayerInputSystem")
  engine:stopSystem("WaveAISystem")
  engine:stopSystem("ProjectileSystem")
end

local function stopMenuSystems()
  engine:stopSystem("MenuInputSystem")
  engine:stopSystem("DrawMenuSystem")
end
-----------------------------------------------
---------- State creation funcitons -----------
local function setIngameState()
  startIngameSystems()
  stopMenuSystems()
end

local function setNewGameState()
  engine:addEntity(createPlayer(getCenter().x, getCenter().y))

  setIngameState()
  curGameState = GameStates.ingame
end

local function setPauseMenuState()
  stopIngameSystems()
  setMenu("pause")
  engine:startSystem("MenuInputSystem")
  engine:startSystem("DrawMenuSystem")
end

local function setGameOverState()
  stopIngameSystems()
  setMenu("gameOver")
  engine:startSystem("MenuInputSystem")
  engine:startSystem("DrawMenuSystem")
end

function changeGameState(gameState)
  curGameState = gameState

  if(gameState == GameStates.ingame) then setIngameState()
  elseif(gameState == GameStates.newGame) then setNewGameState()
  elseif(gameState == GameStates.pauseMenu) then setPauseMenuState()
  elseif(gameState == GameStates.gameOver) then setGameOverState()
  end
end
