GameStates = {
  ingame    = {},
  newGame   = {},
  pauseMenu  = {},
  gameOver  = {}
}


------------- Auxiliary functions -------------
local function startIngameSystems()
  Utils.getEngine():startSystem("TimerSystem")
  Utils.getEngine():startSystem("EnemyAISystem")
  Utils.getEngine():startSystem("MovementSystem")
  Utils.getEngine():startSystem("CollisionSystem")
  Utils.getEngine():startSystem("PlayerInputSystem")
  Utils.getEngine():startSystem("WaveAISystem")
  Utils.getEngine():startSystem("ProjectileSystem")
  Utils.getEngine():startSystem("CleanUpSystem")
end

local function stopIngameSystems()
  Utils.getEngine():stopSystem("TimerSystem")
  Utils.getEngine():stopSystem("EnemyAISystem")
  Utils.getEngine():stopSystem("MovementSystem")
  Utils.getEngine():stopSystem("CollisionSystem")
  Utils.getEngine():stopSystem("PlayerInputSystem")
  Utils.getEngine():stopSystem("WaveAISystem")
  Utils.getEngine():stopSystem("ProjectileSystem")
  Utils.getEngine():stopSystem("ProjectileSystem")
  Utils.getEngine():stopSystem("CleanUpSystem")
end

local function stopMenuSystems()
  Utils.getEngine():stopSystem("MenuInputSystem")
  Utils.getEngine():stopSystem("DrawMenuSystem")
end
-----------------------------------------------
---------- State creation funcitons -----------
local function setIngameState()
  startIngameSystems()
  stopMenuSystems()
end

local function setNewGameState()
  local player = createPlayer(Utils.getCenter().x, Utils.getCenter().y)
  Utils.getEngine():addEntity(player)
  Utils.getEngine():addEntity(createPlayerAttack(player))
  Utils.getEngine():addEntity(createInvunerable(player))

  setIngameState()
  curGameState = GameStates.ingame
end

local function setPauseMenuState()
  stopIngameSystems()
  MenuController.setMenu("pause")
  Utils.getEngine():startSystem("MenuInputSystem")
  Utils.getEngine():startSystem("DrawMenuSystem")
end

local function setGameOverState()
  stopIngameSystems()
  MenuController.setMenu("gameOver")
  Utils.getEngine():startSystem("MenuInputSystem")
  Utils.getEngine():startSystem("DrawMenuSystem")
end

function changeGameState(gameState)
  curGameState = gameState

  if(gameState == GameStates.ingame) then setIngameState()
  elseif(gameState == GameStates.newGame) then setNewGameState()
  elseif(gameState == GameStates.pauseMenu) then setPauseMenuState()
  elseif(gameState == GameStates.gameOver) then setGameOverState()
  end
end
