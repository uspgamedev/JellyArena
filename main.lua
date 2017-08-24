Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

-- components
require "Position"
require "Circle"
require "IsPlayer"
require "Velocity"

-- models
Player = require "Player"
Bullet = require "Bullet"

-- systems
DrawSystem = require "DrawSystem"
PlayerInputSystem = require "PlayerInputSystem"
MovementSystem = require "MovementSystem"

function love.load()
  engine = Engine()
  eventmanager = EventManager()
  engine:addSystem(DrawSystem())
  engine:addSystem(PlayerInputSystem())
  engine:addSystem(MovementSystem())
  engine:addEntity(Player())
end

function love.update(dt)
    -- Engine update function
    engine:update(dt)
end

function love.draw()
    engine:draw()
end
