local SoundController = {}

local tracks = {
  ["sample1"] = love.audio.newSource(love.sound.newSoundData(Utils.getSound("sample1.ogg"))),
  ["sample2"] = love.audio.newSource(love.sound.newSoundData(Utils.getSound("sample2.ogg"))),
  ["sample3"] = love.audio.newSource(love.sound.newSoundData(Utils.getSound("sample3.ogg")))
}

local sounds = {
  ["teste"] = love.audio.newSource(Utils.getSound("select.ogg"), "static")
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
