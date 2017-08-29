Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

--- components
require "AttackProperties"
require "Circle"
require "Combat"
require "Color"
require "Hitpoints"
require "IsEnemy"
require "IsPlayer"
require "Position"
require "Projectile"
require "Timer"
require "Velocity"

--- models
Bullet  = require "Bullet"
Enemy   = require "Enemy"
Player  = require "Player"

--- systems
CombatSystem              = require "CombatSystem"
DrawSystem                = require "DrawSystem"
EnemyAISystem             = require "EnemyAISystem"
HudDrawSystem             = require "HudDrawSystem"
MovementSystem            = require "MovementSystem"
PlayerInputSystem         = require "PlayerInputSystem"
TimerSystem               = require "TimerSystem"

function love.load()
  engine = Engine()
  eventmanager = EventManager()

  -- Process input
  engine:addSystem(PlayerInputSystem(), "update")
    -- Update player vars and state
    -- Go to menu
  -- process enemy AI
  engine:addSystem(EnemyAISystem(), "update")
    -- Based on current game state
    -- Based on player current input <-- cheating AI
  -- Process movement
  engine:addSystem(MovementSystem(), "update")
    -- Update velocity
    -- Update position
    -- Update collision groups
  -- Process collisions
    -- Find all colliding pairs
    -- Process each pair (maybe use callbacks for collision response, like play sound, die, etc)
      -- If we 'delete' something, invalidade all remaining collisions for that body
      -- If not, just separate both bodies (may generate new collisions, not that important)
  -- Update timers
  engine:addSystem(TimerSystem(), "update")
  -- Update statistics (collision response can also change statistics)
  -- Update animations & visual effects
  -- Do clean up
  -- Display
  engine:addSystem(DrawSystem(), "draw")
  engine:addSystem(HudDrawSystem(), "draw")

  -- ???
  --engine:addSystem(CombatSystem(), "update")

  engine:addEntity(Player(love.graphics.getWidth()/2, love.graphics.getHeight()/2))
  engine:addEntity(Enemy(300, 300))
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine:draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit(0)
  end
end
