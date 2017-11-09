Vector = require("lib/hump/vector")
Camera = require("lib/hump/camera")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize(
  {
    debug = true,
    globals = true
  }
)
Stack = require "lib/Stack"

Utils = require("lib/Utils")
SoundController = require("lib/SoundController")
MenuController = require("lib/MenuController")
WaveController = require("lib/WaveController")
StatisticController = require("lib/StatisticController")
ActionsController = require("lib/ActionsController")
LogController = require("lib/LogController")

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
require "components/LifeTime"
require "components/Position"
require "components/Projectile"
require "components/RemainingPoints"
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
DrawSystem = require "systems/draw/DrawSystem"
DrawHUDSystem = require "systems/draw/DrawHUDSystem"
DrawMenuSystem = require "systems/draw/DrawMenuSystem"
DrawMessageSystem = require "systems/draw/DrawMessageSystem"

TimerSystem = require "systems/TimerSystem"

PlayerInputSystem = require "systems/input/PlayerInputSystem"
MenuInputSystem = require "systems/input/MenuInputSystem"

EnemyAISystem = require "systems/EnemyAISystem"
MovementSystem = require "systems/MovementSystem"
CollisionSystem = require "systems/CollisionSystem"
WaveAISystem = require "systems/WaveAISystem"
ProjectileSystem = require "systems/ProjectileSystem"
CleanUpSystem = require "systems/CleanUpSystem"
TrapSpawnSystem = require "systems/TrapSpawnSystem"

--- Utils
require "lib/GameState"

function love.load()
  eventmanager = EventManager()

  playTrack = true
  playEffects = true

  -- TODO: random seed
  -- math.randomseed(os.time())
  LogController.init({"wave"})
  SoundController.setTrack("sample1")
  camera = Camera()
  -- Update timers
  Utils.getEngine():addSystem(TimerSystem(), "update")
  -- Process input
  Utils.getEngine():addSystem(PlayerInputSystem(), "update")
  Utils.getEngine():addSystem(MenuInputSystem(), "update")
  -- Update player vars and state
  -- Go to menu
  -- process wave AI
  Utils.getEngine():addSystem(WaveAISystem(), "update")
  -- select group of enemies to spawn
  -- process group AI
  -- process individual enemy AI
  Utils.getEngine():addSystem(EnemyAISystem(), "update")
  -- Based on current game state
  -- Based on player current input <-- cheating AI
  -- Process movement
  Utils.getEngine():addSystem(MovementSystem(), "update")
  Utils.getEngine():addSystem(ProjectileSystem(), "update")
  -- Update velocity
  -- Update position
  -- Update collision groups
  -- Process collisions
  Utils.getEngine():addSystem(CollisionSystem(), "update")
  -- Find all colliding pairs
  -- Process each pair (maybe use callbacks for collision response, like play sound, die, etc)
  -- If we 'delete' something, invalidade all remaining collisions for that body
  -- If not, just separate both bodies (may generate new collisions, not that important)
  -- Update statistics (collision response can also change statistics)
  -- Update animations & visual effects
  -- Do clean up
  -- Display
  Utils.getEngine():addSystem(DrawSystem(), "draw")
  Utils.getEngine():addSystem(DrawHUDSystem(), "draw")
  Utils.getEngine():addSystem(DrawMessageSystem(), "draw")
  Utils.getEngine():addSystem(DrawMenuSystem(), "draw")
  Utils.getEngine():addSystem(CleanUpSystem(), "update")
  Utils.getEngine():addSystem(TrapSpawnSystem(), "update")

  changeGameState("startingGame")
end

function love.update(dt)
  Utils.getEngine():update(dt)
  SoundController.playTrack()
end

function love.draw()
  Utils.getEngine():draw()
end

function love.keypressed(key)
  if (key == "escape") then
    LogController.close()
    love.event.quit(0)
  elseif (key == "m") then
    if (curGameState == "pauseMenu") then
      changeGameState(popGameState())
    else
      changeGameState("pauseMenu")
    end
  end
end
