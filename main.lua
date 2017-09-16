Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

require("lib/utils")

--- components
require "components/AttackProperties"
require "components/Background"
require "components/Circle"
require "components/Collider"
require "components/Color"
require "components/Hitpoints"
require "components/IsEnemy"
require "components/IsPlayer"
require "components/Position"
require "components/Projectile"
require "components/Text"
require "components/Title"
require "components/Timer"
require "components/Velocity"


--- Entities
require "entities/Damage"
require "entities/Bullet"
require "entities/Enemy"
require "entities/HpDrop"
require "entities/Player"
require "entities/Message"
require "entities/Menu"

--- systems
DrawSystem                = require "systems/DrawSystem"
HudDrawSystem             = require "systems/HudDrawSystem"
DrawMenuSystem            = require "systems/DrawMenuSystem"

TimerSystem               = require "systems/TimerSystem"
MessageSystem             = require "systems/MessageSystem"

PlayerInputSystem         = require "systems/PlayerInputSystem"
TestMenuInputSystem       = require "systems/TestMenuInputSystem"
GameOverInputSystem       = require "systems/GameOverInputSystem"

EnemyAISystem             = require "systems/EnemyAISystem"
MovementSystem            = require "systems/MovementSystem"
CollisionSystem           = require "systems/CollisionSystem"
WaveAISystem              = require "systems/WaveAISystem"
ProjectileSystem          = require "systems/ProjectileSystem"


--- Utils
require "lib/GameState"

function love.load()
  engine = Engine()
  eventmanager = EventManager()
  debug_text = ""
  curGameState = GameStates.newGame

  -- Update timers
  engine:addSystem(TimerSystem(), "update")
  -- Process input
  engine:addSystem(PlayerInputSystem(), "update")
  engine:addSystem(TestMenuInputSystem(), "update")
  engine:addSystem(GameOverInputSystem(), "update")
    -- Update player vars and state
    -- Go to menu
  -- process wave AI
  engine:addSystem(WaveAISystem(), "update")
    -- select group of enemies to spawn
    -- process group AI
  -- process individual enemy AI
  engine:addSystem(EnemyAISystem(), "update")
    -- Based on current game state
    -- Based on player current input <-- cheating AI
  -- Process movement
  engine:addSystem(MovementSystem(), "update")
  engine:addSystem(ProjectileSystem(), "update")
    -- Update velocity
    -- Update position
    -- Update collision groups
  -- Process collisions
  engine:addSystem(CollisionSystem(), "update")
    -- Find all colliding pairs
    -- Process each pair (maybe use callbacks for collision response, like play sound, die, etc)
      -- If we 'delete' something, invalidade all remaining collisions for that body
      -- If not, just separate both bodies (may generate new collisions, not that important)
  -- Update statistics (collision response can also change statistics)
  -- Update animations & visual effects
  -- Do clean up
  -- Display
  engine:addSystem(DrawSystem(), "draw")
  engine:addSystem(HudDrawSystem(), "draw")
  engine:addSystem(MessageSystem(), "draw")
  engine:addSystem(DrawMenuSystem(), "draw")

  changeGameState(curGameState)
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine:draw()
end

function love.keypressed(key)
  if(key == "escape") then
    love.event.quit(0)

  elseif(key == "m") then
    if(curGameState == GameStates.ingame) then
      changeGameState(GameStates.testMenu)

    elseif(curGameState == GameStates.testMenu) then
      -- TODO: handle messaging properly
      debug_text = ""
      changeGameState(GameStates.ingame)
    end
  end
end
