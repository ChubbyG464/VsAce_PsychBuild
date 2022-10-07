local bgX = -1100
local bgY = -1350
local scr = 0.92

function onCreate()


	makeLuaSprite('bg', 'minusbg', bgX, bgY)
	setScrollFactor('bg', scr, scr)
	addLuaSprite('bg')
	
	makeAnimatedLuaSprite('flag', 'Flag', bgX + 1088*0.9, bgY + 130*0.9)
	addAnimationByPrefix('flag', 'day', 'Flag Wave Day', 12)
	setScrollFactor('flag', scr, scr)
	addLuaSprite('flag')
	
	makeAnimatedLuaSprite('glass', 'mics', bgX + (1121 * 0.9), bgY + (455 * 0.9))
	addAnimationByPrefix('glass', 'day', 'Day', 0, false)
	setScrollFactor('glass', scr, scr)
	--scaleObject('glass',0.9, 0.9)
	addLuaSprite('glass')
	
	makeLuaSprite('overlay', 'overlay1', bgX, bgY)
	setScrollFactor('overlay', scr, scr)
	setBlendMode('overlay', 'add')
	addLuaSprite('overlay')
	


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