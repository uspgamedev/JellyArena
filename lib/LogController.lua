local LogController = class("LogController")
local files = {}
local function fileName(file)
  return string.format("log/%s.log", file)
end

function LogController.init(filenames)
  love.filesystem.createDirectory("log")
  for _, file in pairs(filenames) do
    f = love.filesystem.newFile(fileName(file))
    assert(f:open("w"))
    f:close()
    assert(f:open("a"))
    files[file] = f
  end
end

function LogController.write(file, text)
  files[file]:write(text .. "\n")
end

function LogController.close()
  for _, f in pairs(files) do
    f:close()
  end
end

return LogController
