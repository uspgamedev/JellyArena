local RemainingPoints = Component.create("RemainingPoints")

function RemainingPoints:initialize(remaining)
  self.remaining = remaining
end

function RemainingPoints:add (num)
  self.remaining = self.remaining + num
end

function RemainingPoints:spend(num)
  self.remaining = self.remaining - num
end
