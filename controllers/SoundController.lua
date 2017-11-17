local SoundController = {}

local function getSound(filename)
  return "resources/sounds/"..filename
end

local tracks = {
  ["menu"] = love.audio.newSource(love.sound.newSoundData(getSound("sample1.ogg"))),
  ["waves"] = love.audio.newSource(love.sound.newSoundData(getSound("waves.ogg"))),
  ["boss"] = love.audio.newSource(love.sound.newSoundData(getSound("boss.ogg"))),
  ["gameover"] = love.audio.newSource(love.sound.newSoundData(getSound("gameover.ogg")))
}

local trackDuration = {
  ["menu"] = 24,
  ["waves"] = 167,
  ["boss"] = 137
}

local sounds = {
  ["select"] = love.audio.newSource(getSound("select.ogg"), "static"),
  ["shot"] = love.audio.newSource(getSound("shot.ogg"), "static"),
  ["hit"] = love.audio.newSource(getSound("hit.ogg"), "static"),
  ["melee"] = love.audio.newSource(getSound("melee.ogg"), "static"),
}

local currentTrack
local currentTrackName
local trackTime = 0
local looping = true

function SoundController.setTrack(trackName)
  if tracks[trackName] and trackName ~= currentTrackName then
    if currentTrack then
      love.audio.stop(currentTrack)
    end
    currentTrackName = trackName
    currentTrack = tracks[trackName]
    currentTrack:setVolume(0.5)
    currentTrack:setLooping(looping)
    trackTime = 0
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

function SoundController.checkDuration(dt)
  if (looping and trackTime >= trackDuration[currentTrackName]) then
    love.audio.stop(currentTrack)
    trackTime = 0
  end
  trackTime = trackTime + dt
end

SoundController.setLooping(bool)
  looping = bool
end

SoundController.isMusicOn = true

SoundController.isEffectOn = true

return SoundController
