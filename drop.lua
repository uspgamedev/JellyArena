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
  self:checkPlayerCollision(game, dt)
  return self.taken
end

function Drop:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

function Drop:checkPlayerCollision(game, dt)
  if (game.player.position - self.position):len() < self.radius + game.player.radius then
    if self.type == 'hp' then game.player:recoverHp(math.random(5))
    elseif self.type  == 'maxHp' then game.player.maxHp = game.player.maxHp + 1
    elseif self.type  == 'bulletDamage' then game.player.bulletDamage = game.player.bulletDamage + 1
    elseif self.type  == 'bulletSpeed' then game.player.bulletSpeed = game.player.bulletSpeed + 100
    elseif self.type  == 'speed' then game.player.speed = game.player.speed + 20
    else game.player.fireDelay = game.player.fireDelay - 0.01
    end
    self.taken = true
  end
end
