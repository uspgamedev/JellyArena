local Stack = class("Stack")

function Stack:initialize()
  self.list = {}
  self.last = 0
end

function Stack:size()
  return self.last
end

function Stack:isEmpty()
  return (self.last == 0)
end

function Stack:push(value)
  if value == nil then
    return
  end
  self.last = self.last + 1
  self.list[self.last] = value
end

function Stack:multiPush(values)
  if values == nil then
    return
  end
  for _, v in pairs(values) do
    self:push(v)
  end
end

function Stack:pop()
  local value = self.list[self.last]
  self.list[self.last] = nil
  self.last = self.last - 1
  return value
end

return Stack
