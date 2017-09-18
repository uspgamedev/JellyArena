local Title, Background =
  Component.load({"Title", "Background",})

function createMenu(title, backgrund_color)
  local entity = Entity()
  entity:add(Title(title))
  entity:add(Background(backgrund_color))
  return entity
end
