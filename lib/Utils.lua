local Utils = {}

function Utils.addPlayerPoints(x)
  for _, e in pairs(Utils.getEngine().entities) do
    if e:has("IsPlayer") then
      e:get("RemainingPoints"):add(x)
      break
    end
  end
end

function Utils.getCenter()
  return {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
end

local engine

function Utils.getEngine()
  if engine == nil then
    engine = Engine()
  end
  return engine
end

function Utils.getChild(entity, label)
  for _, child in pairs(entity.children) do
    if (child:has("Label") and child:get("Label").label == label) then
      return child
    end
  end
  return nil
end

-- Table
function Utils.containsValue(table, data)
  for key, value in pairs(table) do
    if (value == data) then
      return true
    end
  end

  return false
end

function Utils.count(table)
  local count = 0
  for _, enemy in pairs(table) do
    count = count + 1
  end
  return count
end

-- Garbage
function Utils.addGarbage(entity)
  local id = entity.id
  if id then
    garbageList[id] = entity
  end
end

function Utils.pairsOrderValuesDesc(tab)
   local keys = {}
   for k in pairs(tab) do
      keys[#keys + 1] = k
   end
   table.sort(keys, function(a, b) return tab[a] > tab[b] end)
   local j = 0
   return
      function()
         j = j + 1
         local k = keys[j]
         if k ~= nil then
            return k, tab[k]
         end
      end
end

local font
function Utils.defaultFont()
  if font == nil then
    font = love.graphics.newFont("resources/fonts/PressStart2P.ttf")
  end
  return font
end

Utils.mapDefinitions = {
  height = 896, -- 28 tiles
  width = 896,
  xOffset = 640,
  yOffset = 640
}

return Utils
