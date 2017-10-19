local LogController = class("LogController")

function LogController.init(files)
  for _, file in pairs(files) do
    local f = io.open(file, "w+")
    f:close()
  end
end

function LogController.write(file, text)
  local file = io.open(file, "a")
  file:write(text.."\n")
  file:close()
end

return LogController