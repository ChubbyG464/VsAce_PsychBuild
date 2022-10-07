local bgX = -1100
local bgY = -1350
local scr = 0.92

function onCreate()


	makeLuaSprite('bg', 'stages/minus/minussweater', bgX, bgY)
	setScrollFactor('bg', scr, scr)
	addLuaSprite('bg')
	



end

function onCreatePost()
    scaleObject("dad", 1.1, 1.1, false)

	setProperty("gf.scrollFactor.x", 0.92)
	setProperty("gf.scrollFactor.y", 0.92)
	setProperty("boyfriend.scrollFactor.x", 0.92)
	setProperty("boyfriend.scrollFactor.y", 0.92)
	setProperty("dad.scrollFactor.x", 0.92)
	setProperty("dad.scrollFactor.y", 0.92)
      
end	