local bgX = -1100
local bgY = -1350
local scr = 0.92

local lSongName = ""

function onCreate()
	lSongName = string.lower(songName):gsub(" ", "-")

	makeLuaSprite('bg', 'stages/minus/minusbg', bgX, bgY)
	setScrollFactor('bg', scr, scr)
	addLuaSprite('bg')

	if lSongName == "icing-tensions" then
		setProperty("hideOpponent2", false)
	end



end

function onCreatePost()
	scaleObject("dad", 1.1, 1.1, false)
	if dadName == "maku" then
		scaleObject("dad", 1.25, 1.25, false)
	end

	setProperty("gf.scrollFactor.x", 0.92)
	setProperty("gf.scrollFactor.y", 0.92)
	setProperty("boyfriend.scrollFactor.x", 0.92)
	setProperty("boyfriend.scrollFactor.y", 0.92)
	setProperty("dad.scrollFactor.x", 0.92)
	setProperty("dad.scrollFactor.y", 0.92)
	close(true)
end