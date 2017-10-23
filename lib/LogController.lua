local LogController = class("LogController")

local function fileName(file)
  local dir = love.filesystem.getSource()
  return string.format("%s/log/%s.log", dir, file)
end

function LogController.init(files)
  for _, file in pairs(files) do
    local f = assert(io.open(fileName(file), "w"))
    f:close()
  end
end

function LogController.write(file, text)
  local f = assert(io.open(fileName(file), "a"))
  f:write(text .. "\n")
  f:close()
end

return LogController
