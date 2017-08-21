Drop = Object:extend()


function Drop:new(x, y)
  self.position = Vector(x,y)
  self.radius = 5
  self.color = {0, 255, 255}
  self.type = generateDrop()
  self.taken = false
end

function generateDrop()
  --TODO: balance odds
  local random = math.random()
  local type
  if random > 0.1 then
    type = 'hp'
  else
    if random < 0.02 then type = 'maxHp'
    elseif random < 0.04 then type = 'bulletDamage'
    elseif random < 0.06 then type = 'bulletSpeed'
    elseif random < 0.08 then type = 'speed'
    else type = 'fireDelay'
    end
  end
  return type
end

function Drop:update(game, dt)
  self:checkPlayerCollision(game)
  return self.taken
end

function Drop:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

function Drop:checkPlayerCollision(game)
  if (game.player.position - self.position):len() < self.radius + game.player.radius then
    self:activateEffect(game.player)
    self.taken = true
  end
end

function Drop:activateEffect(player)
  if self.type == 'hp' then player:recoverHp(math.random(5))
  else player:upgrade(self.type)
  end
end
