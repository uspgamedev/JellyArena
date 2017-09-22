local SoundSystem = class("SoundSystem", System)

music = {
  sample1 = love.audio.newSource(love.sound.newSoundData(getSound("sample_1.ogg"))),
  sample2 = love.audio.newSource(love.sound.newSoundData(getSound("sample_2.ogg")))
}

sounds = {
  teste = love.audio.newSource(getSound("select.ogg"), "static")
}

function SoundSystem:update(dt)
  music.sample1:setVolume(0.5)
  music.sample1:setLooping(true)
  love.audio.play(music.sample1)
end

return SoundSystem
