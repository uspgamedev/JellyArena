local tracks = {
  ["sample1"] = love.audio.newSource(love.sound.newSoundData(getSound("sample_1.ogg"))),
  ["sample2"] = love.audio.newSource(love.sound.newSoundData(getSound("sample_2.ogg"))),
  ["sample3"] = love.audio.newSource(love.sound.newSoundData(getSound("sample_3.ogg")))
}

local sounds = {
  ["teste"] = love.audio.newSource(getSound("select.ogg"), "static")
}

local current_track

function setTrack(trackName)
  if ( tracks[trackName] ~= nil ) then
    if (current_track ~= nil) then
      love.audio.stop(current_track)
    end
    current_track = tracks[trackName]
    current_track:setVolume(0.5)
    current_track:setLooping(true)
  end
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
