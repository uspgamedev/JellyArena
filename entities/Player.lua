local Position, Circle, IsPlayer, Velocity, WindowLimited, AttackProperties, Timer, HP, Color =
  Component.load({"Position", "Circle", "IsPlayer", "Velocity", "WindowLimited", "AttackProperties", "Timer", "Hitpoints", "Color"})

function createPlayer(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(20))
  entity:add(Velocity(0, 0, 500))
  entity:add(WindowLimited())
  entity:add(AttackProperties(5, 25))
  entity:add(HP(20))
  entity:add(Timer(0.3))
  entity:add(IsPlayer())
  entity:add(Color(255, 255, 255))
  return entity
end
