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

	setScrollFactor("dad", 1.1, 1.1)
	setScrollFactor("boyfriend", 1.1, 1.1)
	setScrollFactor("gf", 1.1, 1.1)

end

