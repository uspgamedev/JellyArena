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
  engine:startSystem("CleanUpSystem")
end

local function stopIngameSystems()
  engine:stopSystem("TimerSystem")
  engine:stopSystem("EnemyAISystem")
  engine:stopSystem("MovementSystem")
  engine:stopSystem("CollisionSystem")
  engine:stopSystem("PlayerInputSystem")
  engine:stopSystem("WaveAISystem")
  engine:stopSystem("ProjectileSystem")
  engine:stopSystem("CleanUpSystem")
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
  local player = createPlayer(getCenter().x, getCenter().y)
  engine:addEntity(player)
  engine:addEntity(createPlayerAttack(player))
  engine:addEntity(createInvunerable(player))

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
