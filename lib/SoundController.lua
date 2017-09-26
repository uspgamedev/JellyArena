local tracks = {
  ["sample1"] = love.audio.newSource(love.sound.newSoundData(getSound("sample_1.ogg"))),
  ["sample2"] = love.audio.newSource(love.sound.newSoundData(getSound("sample_2.ogg")))
}

local sounds = {
  ["teste"] = love.audio.newSource(getSound("select.ogg"), "static")
}

local current_track

function setTrack(trackName)
  if ( tracks[trackName] ~= nil ) then
    current_track = tracks[trackName]
  end
  current_track:setVolume(0.5)
  current_track:setLooping(true)
end

function playSound(soundName)
  if ( sounds[soundName] ~= nil ) then
    love.audio.rewind(sounds[soundName])
    love.audio.play(sounds[soundName])
  end
end

function playTrack()
  if ( current_track ~= nil ) then
    love.audio.play(current_track)
  end
end
