local Text =
  Component.load({"Text"})

function createMessage()
  local entity = Entity()
  entity:add(Text())
  return entity
end
