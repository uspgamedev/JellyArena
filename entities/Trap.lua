local Label, Position, Circle, Color, Collider, Visibility =
  Component.load({"Label", "Position", "Circle", "Color", "Collider", "Visibility" })

function createDamageTrap(x, y)
  local entity = Entity()
  entity:add(Label("DamageTrap"))
  entity:add(Position(x, y))
  entity:add(Circle(10))
  entity:add(Color(100, 15, 15))
  entity:add(Collider("Trap", true))
  entity:add(Visibility(true))
  return entity
end

function createPushTrap(x, y)
  local entity = Entity()
  entity:add(Label("PushTrap"))
  entity:add(Position(x, y))
  entity:add(Circle(10))
  entity:add(Color(15, 15, 100))
  entity:add(Collider("Trap", true))
  entity:add(Visibility(true))
  return entity
end

function createHealingTrap(x, y)
  local entity = Entity()
  entity:add(Label("HealingTrap"))
  entity:add(Position(x, y))
  entity:add(Circle(10))
  entity:add(Color(15, 100, 15))
  entity:add(Collider("Trap", true))
  entity:add(Visibility(false))
  return entity
end
