local SoundController = {}

local function getSound(filename)
  return "resources/sounds/"..filename
end

local tracks = {
  ["menu"] = love.audio.newSource(love.sound.newSoundData(getSound("sample1.ogg"))),
  ["waves"] = love.audio.newSource(love.sound.newSoundData(getSound("waves.ogg"))),
  ["boss"] = love.audio.newSource(love.sound.newSoundData(getSound("boss.ogg")))
}

local sounds = {
  ["select"] = love.audio.newSource(getSound("select.ogg"), "static"),
  ["shot"] = love.audio.newSource(getSound("shot.ogg"), "static"),
  ["hit"] = love.audio.newSource(getSound("hit.ogg"), "static"),
  ["melee"] = love.audio.newSource(getSound("melee.ogg"), "static"),
}

local currentTrack

function SoundController.setTrack(trackName)
  if tracks[trackName] then
    if currentTrack then
      love.audio.stop(currentTrack)
    end
    currentTrack = tracks[trackName]
    currentTrack:setVolume(0.5)
    currentTrack:setLooping(true)
  end
end

function SoundController.playSound(soundName)
  if (SoundController.isEffectOn and sounds[soundName]) then
    sounds[soundName]:setVolume(0.2)
    love.audio.rewind(sounds[soundName])
    love.audio.play(sounds[soundName])
  end
end

function SoundController.playTrack()
  if (SoundController.isMusicOn and currentTrack) then
    love.audio.play(currentTrack)
  end
end

SoundController.isMusicOn = true

SoundController.isEffectOn = true

return SoundController
