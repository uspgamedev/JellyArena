GameStates = {
  ingame    = {},
  newGame   = {},
  testMenu  = {},
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
  engine:stopSystem("TestMenuInputSystem")
  engine:stopSystem("GameOverInputSystem")
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

  setIngameState()
  curGameState = GameStates.ingame
end

local function setTestMenuState()
  stopIngameSystems()

  -- TODO: create menu
  debug_text = "DEBUG: Test Menu (press M to exit)"

  engine:startSystem("TestMenuInputSystem")
  engine:startSystem("DrawMenuSystem")
end

local function setGameOverState()
  stopIngameSystems()

  -- TODO: create menu
  debug_text = "Game Over! Press r to restart game"
  engine:startSystem("GameOverInputSystem")
  engine:startSystem("DrawMenuSystem")
end

function changeGameState(gameState)
  curGameState = gameState

  if(gameState == GameStates.ingame) then setIngameState()
  elseif(gameState == GameStates.newGame) then setNewGameState()
  elseif(gameState == GameStates.testMenu) then setTestMenuState()
  elseif(gameState == GameStates.gameOver) then setGameOverState()
  end
end
