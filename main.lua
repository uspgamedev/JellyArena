Vector = require("lib/hump/vector")
Camera = require("lib/hump/camera")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})
Stack = require "lib/Stack"

require ("lib/Utils")
require ("lib/SoundController")
require ("lib/MenuController")
WaveController = require ("lib/WaveController")
Statistic = require ("lib/StatisticController")
ActionsController = require("lib/ActionsController")
Log = require("lib/LogController")

--- components
require "components/AI"
require "components/AttackProperties"
require "components/AttackRange"
require "components/Circle"
require "components/Collider"
require "components/Color"
require "components/Damage"
require "components/Follow"
require "components/Hitpoints"
require "components/IsPlayer"
require "components/Label"
require "components/Position"
require "components/Projectile"
require "components/Timer"
require "components/Velocity"
require "components/Stats"
require "components/Visibility"


--- Entities
require "entities/Attack"
require "entities/Invunerable"
require "entities/Bullet"
require "entities/DamageArea"
require "entities/Enemy"
require "entities/HpDrop"
require "entities/Player"
require "entities/Trap"

--- systems
DrawSystem                = require "systems/draw/DrawSystem"
DrawHUDSystem             = require "systems/draw/DrawHUDSystem"
DrawMenuSystem            = require "systems/draw/DrawMenuSystem"
DrawMessageSystem         = require "systems/draw/DrawMessageSystem"

TimerSystem               = require "systems/TimerSystem"

PlayerInputSystem         = require "systems/input/PlayerInputSystem"
MenuInputSystem           = require "systems/input/MenuInputSystem"

EnemyAISystem             = require "systems/EnemyAISystem"
MovementSystem            = require "systems/MovementSystem"
CollisionSystem           = require "systems/CollisionSystem"
WaveAISystem              = require "systems/WaveAISystem"
ProjectileSystem          = require "systems/ProjectileSystem"
CleanUpSystem             = require "systems/CleanUpSystem"
TrapSpawnSystem           = require "systems/TrapSpawnSystem"


--- Utils
require "lib/GameState"

function love.load()
  eventmanager = EventManager()
  debug_text = ""
  garbage_list = {}
  play_track = true
  play_effects = true
  curGameState = GameStates.newGame
  WaveController.createLearningList()
  Statistic.reset()
  -- TODO: random seed
  -- math.randomseed(os.time())
  Log.init({"wave"})
  setTrack("sample1")

  -- Update timers
  getEngine():addSystem(TimerSystem(), "update")
  -- Process input
  getEngine():addSystem(PlayerInputSystem(), "update")
  getEngine():addSystem(MenuInputSystem(), "update")
    -- Update player vars and state
    -- Go to menu
  -- process wave AI
  getEngine():addSystem(WaveAISystem(), "update")
    -- select group of enemies to spawn
    -- process group AI
  -- process individual enemy AI
  getEngine():addSystem(EnemyAISystem(), "update")
    -- Based on current game state
    -- Based on player current input <-- cheating AI
  -- Process movement
  getEngine():addSystem(MovementSystem(), "update")
  getEngine():addSystem(ProjectileSystem(), "update")
    -- Update velocity
    -- Update position
    -- Update collision groups
  -- Process collisions
  getEngine():addSystem(CollisionSystem(), "update")
    -- Find all colliding pairs
    -- Process each pair (maybe use callbacks for collision response, like play sound, die, etc)
      -- If we 'delete' something, invalidade all remaining collisions for that body
      -- If not, just separate both bodies (may generate new collisions, not that important)
  -- Update statistics (collision response can also change statistics)
  -- Update animations & visual effects
  -- Do clean up
  -- Display
  getEngine():addSystem(DrawSystem(), "draw")
  getEngine():addSystem(DrawHUDSystem(), "draw")
  getEngine():addSystem(DrawMessageSystem(), "draw")
  getEngine():addSystem(DrawMenuSystem(), "draw")
  getEngine():addSystem(CleanUpSystem(), "update")
  getEngine():addSystem(TrapSpawnSystem(), "update")

  changeGameState(curGameState)
end

function love.update(dt)
    getEngine():update(dt)
    playTrack()
end

function love.draw()
    getEngine():draw()
end

function love.keypressed(key)
  if(key == "escape") then
    Log.close()
    love.event.quit(0)

  elseif(key == "m") then
    if(curGameState == GameStates.ingame) then
      changeGameState(GameStates.pauseMenu)

    elseif(curGameState == GameStates.pauseMenu) then
      changeGameState(GameStates.ingame)
    end
  end
end
