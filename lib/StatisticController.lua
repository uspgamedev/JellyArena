local statistic = {}

local score

function statistic.reset()
  score = 0
end

function statistic.add(i)
  score = score + i
end

function statistic.getScore()
  return score
end

return statistic