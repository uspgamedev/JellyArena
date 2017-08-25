Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

-- components
require "IsPlayer"
require "Position"
require "Circle"
require "Velocity"
require "Combat"
require "Projectile"

-- models
Player = require "Player"
Bullet = require "Bullet"

-- systems
DrawSystem = require "DrawSystem"
PlayerInputSystem = require "PlayerInputSystem"
MovementSystem = require "MovementSystem"
CombatSystem = require "CombatSystem"

function love.load()
  engine = Engine()
  eventmanager = EventManager()
  engine:addSystem(DrawSystem())
  engine:addSystem(PlayerInputSystem())
  engine:addSystem(MovementSystem())
  engine:addSystem(CombatSystem())
  engine:addEntity(Player())
end

function love.update(dt)
    -- Engine update function
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
