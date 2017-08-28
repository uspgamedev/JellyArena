Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

-- components
require "IsPlayer"
require "IsEnemy"
require "Position"
require "Circle"
require "Velocity"
require "Combat"
require "Projectile"

-- models
Player = require "Player"
Enemy = require "Enemy"
Bullet = require "Bullet"

-- systems
PlayerInputSystem   = require "PlayerInputSystem"
EnemyAISystem       = require "EnemyAISystem"
MovementSystem      = require "MovementSystem"
CombatSystem        = require "CombatSystem"
DrawSystem          = require "DrawSystem"
HudDrawSystem       = require "HudDrawSystem"

function love.load()
  engine = Engine()
  eventmanager = EventManager()

  engine:addSystem(PlayerInputSystem())
  engine:addSystem(EnemyAISystem())
  engine:addSystem(MovementSystem())
  engine:addSystem(CombatSystem())
  engine:addSystem(DrawSystem())
  engine:addSystem(HudDrawSystem())

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
