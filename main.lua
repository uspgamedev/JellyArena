Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

require("lib/utils")

--- components
require "components/AttackProperties"
require "components/Circle"
require "components/Collidable"
require "components/Color"
require "components/Hitpoints"
require "components/IsCollidable"
require "components/IsEnemy"
require "components/IsPlayer"
require "components/Position"
require "components/WindowLimited"
require "components/Projectile"
require "components/Timer"
require "components/Velocity"

--- Entities
require "entities/Bullet"
require "entities/Enemy"
require "entities/HpDrop"
require "entities/Player"

--- systems
DrawSystem                = require "systems/DrawSystem"
EnemyAISystem             = require "systems/EnemyAISystem"
HudDrawSystem             = require "systems/HudDrawSystem"
MovementSystem            = require "systems/MovementSystem"
CollisionSystem           = require "systems/CollisionSystem"
PlayerInputSystem         = require "systems/PlayerInputSystem"
TimerSystem               = require "systems/TimerSystem"
WaveAISystem              = require "systems/WaveAISystem"
ProjectileSystem          = require "systems/ProjectileSystem"

function love.load()
  engine = Engine()
  eventmanager = EventManager()
  world = love.physics.newWorld(0, 0, true)

  -- Process input
  engine:addSystem(PlayerInputSystem(), "update")
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
    -- Find all colliding pairs
    -- Process each pair (maybe use callbacks for collision response, like play sound, die, etc)
      -- If we 'delete' something, invalidade all remaining collisions for that body
      -- If not, just separate both bodies (may generate new collisions, not that important)
  engine:addSystem(CollisionSystem(), "update")
  -- Update timers
  engine:addSystem(TimerSystem(), "update")
  -- Update statistics (collision response can also change statistics)
  -- Update animations & visual effects
  -- Do clean up
  -- Display
  engine:addSystem(DrawSystem(), "draw")
  engine:addSystem(HudDrawSystem(), "draw")

  engine:addEntity(createEnemy(300, 300))
  engine:addEntity(createPlayer(getCenter().x, getCenter().y))
end

function love.update(dt)
    engine:update(dt)
    world:update(dt)
end

function love.draw()
    engine:draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit(0)
  end
end
