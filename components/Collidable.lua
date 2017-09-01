local Collidable  = Component.create("Collidable")

function Collidable:initialize(world, x, y, radius)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.body:setMass(0.1)
  self.shape = love.physics.newCircleShape(radius)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setRestitution(0.5)
end
