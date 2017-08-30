function getCenter()
  return {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function distToPix(distance)
  maxDist = getCenter().x
  return distance / 10 * maxDist
end
