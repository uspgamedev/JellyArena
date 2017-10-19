local statistic = {}

local score = {}

function statistic.reset()
  score = {}
end

function statistic.add(i)
  if score.Wave then
    score.Wave = score.Wave + i
  else
    score.Wave = i
  end
end

function statistic.addToAction(i, action)
  for a,s in pairs(score) do
    if a == action then
      score[a] = s + i
      return
    end
  end
  score[action] = i
end

function statistic.addToActions(i, actions)
  statistic.add(i)
  for _,action in pairs(actions) do
    statistic.addToAction(i, action.name)
  end
end

function statistic.getScore()
  Log.write("wave.log", "-SCORE-")
  for k,v in pairs(score) do
    Log.write("wave.log", k..":\t"..v)
  end
  Log.write("wave.log", "-------")
  return score
end

function statistic.getWaveScore()
  if score.Wave then
    return score.Wave
  end
  return 0
end

function statistic.getActionScore(action)
  if score[action] then
    return score[action]
  end
  return 0
end

return statistic