function onCreate()
	-- background shit
	makeLuaSprite('background1', 'background1', -1400, -1400);
	setScrollFactor('background1', 1.1, 1.1);
	
	makeLuaSprite('Fences', 'Fences', -1922, -1720);
	setScrollFactor('Fences', 1.1, 1.1);
	scaleObject('Fences', 1, 1);

	makeLuaSprite('P2Snow1', 'P2Snow1', -1400, -1400);
	setLuaSpriteScrollFactor('P2Snow1', 1.1, 1.1);
	scaleObject('P2Snow1', 1, 1);

	makeLuaSprite('Overlay', 'Overlay', -1400, -1400);
	setLuaSpriteScrollFactor('Overlay', 1.1, 1.1);
	scaleObject('Overlay', 1, 1);

	makeLuaSprite('Lamps', 'Lamps', -1400, -1400);
	setLuaSpriteScrollFactor('Lamps', 1.1, 1.1);
	scaleObject('Lamps', 1, 1);

	makeAnimatedLuaSprite('BackC','Back_Characters', -820,-795)
	addAnimationByPrefix('BackC','dance','bop',24,true)
	objectPlayAnimation('BackC','dance',false)
	setScrollFactor('BackC', 1.1, 1.1);

	makeAnimatedLuaSprite('FrontC','Front_Characters', -1285,-610)
	addAnimationByPrefix('FrontC','dance','bop',24,true)
	objectPlayAnimation('FrontC','dance',false)
	setScrollFactor('FrontC', 1.1, 1.1);

		
	addLuaSprite('background1', false);
	addLuaSprite('BackC', false);
	addLuaSprite('Fences', false);
	addLuaSprite('P2Snow1', false);
	addLuaSprite('FrontC', false);
	addLuaSprite('Lamps', true);
	addLuaSprite('Overlay', true);
		
end

function onBeatHit()
	objectPlayAnimation("BackC", "dance", true)
	objectPlayAnimation("FrontC", "dance", true)
end

function onCreatePost()
	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)

end	
	
	
	
