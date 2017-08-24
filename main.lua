Vector = require("lib/hump/vector")
lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({
  debug = true,
  globals = true
})

-- components
require "Position"
require "Circle"


-- models
Player = require "Player"

-- systems
DrawSystem = require "DrawSystem"

local Position  = Component.load({"Position"})

function love.load()
  engine = Engine()
  eventmanager = EventManager()
  engine:addSystem(DrawSystem())

  engine:addEntity(Player())
end

function love.update(dt)
    -- Engine update function
    engine:update(dt)
end

function love.draw()
    engine:draw()
end
