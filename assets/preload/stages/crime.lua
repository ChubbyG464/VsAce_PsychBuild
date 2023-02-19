function onCreate()
	-- background shit
	makeLuaSprite('background', 'stages/bridge/crime/background1', -1400, -1400);
	setScrollFactor('background', 1.1, 1.1);
	scaleObject('bridge', 1, 1);

	makeLuaSprite('foreground', 'stages/bridge/crime/foreground', -1400, -1400);
	setLuaSpriteScrollFactor('W2foreground', 1.1, 1.1);
	scaleObject('W2foreground', 1, 1);

	makeAnimatedLuaSprite('BackC','stages/ace/wallart', -1400,-1400)
	addAnimationByPrefix('BackC','dance','vibe',24,true)
	objectPlayAnimation('BackC','dance',false)
	setScrollFactor('BackC', 1.1, 1.1);


	addLuaSprite('background', false);
	addLuaSprite('BackC', false);
	addLuaSprite('foreground', true);

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

