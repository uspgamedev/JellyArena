local Title, Background =
  Component.load({"Title", "Background",})

function createMenu(title)
  local entity = Entity()
  entity:add(Title(title))
  entity:add(Background({ r = 0, g = 0, b = 0 }))
  return entity
end
