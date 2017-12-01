local Position, Circle, Color, Collider, Animation =
  Component.load({"Position", "Circle", "Color", "Collider", "Animation"})

function createHpDrop(x, y)
  local entity = Entity()
  entity:add(Position(x, y))
  entity:add(Circle(8))
  entity:add(Animation(ImageController.getAnimation("health", 1, 1, 16)));
  entity:add(Collider("HpDrop", true))
  return entity
end
