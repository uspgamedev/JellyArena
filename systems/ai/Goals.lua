local Goals = {}

Goals.Damage = {
  name = "Damage",
  weight = function(agent, target, dt)
    return 1
  end
}

Goals.Safety = {
  name = "Safety",
  weight = function(agent, target, dt)
    return 0
  end
}

return Goals
