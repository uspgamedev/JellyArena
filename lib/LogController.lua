local LogController = class("LogController")

local function fileName(file)
  return string.format("log/%s.log", file)
end

function LogController.init(files)
  for _, file in pairs(files) do
    local f, e = io.open(fileName(file), "w")
    if f == nil then
      print("Couldn't open file: " .. e)
    end
    f:close()
  end
end

function LogController.write(file, text)
  local f = io.open(fileName(file), "a")
  f:write(text .. "\n")
  f:close()
end

return LogController
