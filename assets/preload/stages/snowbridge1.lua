function onCreate()
	-- background shit
	makeLuaSprite('snowbridge1', 'stages/bridge/cold/snowbridge1', -1400, -1400);
	setScrollFactor('snowbridge1', 1.1, 1.1);
	
	makeLuaSprite('snowbackground1', 'stages/bridge/cold/snowbackground1', -1400, -1400);
	setScrollFactor('snowbackground1', 1.1, 1.1);
	scaleObject('snowbackground1', 1, 1);

	makeLuaSprite('snowforeground1', 'stages/bridge/cold/snowforeground1', -1400, -1400);
	setLuaSpriteScrollFactor('snowforeground1', 1, 1);
	scaleObject('snowforeground1', 1, 1);

	makeAnimatedLuaSprite('BackC','stages/ace/AceCrowd', -780,-275)
	addAnimationByPrefix('BackC','dance','jam',24,true)
	objectPlayAnimation('BackC','dance',false)
	setScrollFactor('BackC', 1.1, 1.1);

		
	addLuaSprite('snowbackground1', false);
	addLuaSprite('snowbridge1', false);
	addLuaSprite('BackC', false);
	addLuaSprite('snowforeground1', true);
		
	
end

function onBeatHit()
	objectPlayAnimation("BackC", "dance", true)
end

function onCreatePost()
	scaleObject("dad", 1.2, 1.2, false)

	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)

end	