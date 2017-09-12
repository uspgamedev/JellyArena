local CollisionSystem = class("CollisionSystem", System)

function CollisionSystem:update(dt)
  world:setCallbacks(beginContact)
  for i, v in pairs(self.targets.WindowLimited) do
    local position = v:get("Position")
    local radius = v:get("Circle").radius
    if (self:checkWindowLimit(position, radius)) then
      v:get("WindowLimited"):collide()
    end

  end

  for i, v in pairs(self.targets.Collisions) do
    local vPos = v:get("Position"):toVector()
    local vRad = v:get("Circle").radius
    for j, w in pairs(self.targets.Collisions) do
      if (j > i) then
        local wPos = w:get("Position"):toVector()
        local wRad = w:get("Circle").radius
        local dist = (vPos - wPos):len2()
        local minDist = (vRad + wRad) * (vRad + wRad)
        if (dist < minDist) then
          lovetoys.debug("BATEU: "..v.id..":"..w.id)
        end
      end
    end
  end
end

function beginContact(a, b, coll)
  x, y = coll:getNormal()
  text = "colidiu!!!"
end

function CollisionSystem:requires()
  return {
    WindowLimited = { "Position", "Circle", "WindowLimited" },
    Collisions = { "IsCollidable" }
  }
end

function CollisionSystem:checkWindowLimit(position, radius)
  window_width = love.graphics.getWidth() - radius
  window_height = love.graphics.getHeight() - radius
  check = false
  if position.x < radius then
    check = true
    position.x = radius
  elseif position.x > window_width then
    check = true
    position.x = window_width
  end

  if position.y < radius then
    check = true
    position.y = radius
  elseif position.y > window_height then
    check = true
    position.y = window_height
  end

  return check
end

return CollisionSystem
