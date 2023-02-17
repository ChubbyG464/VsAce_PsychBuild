-- CONSTANTS
local HIDDEN = 0.0000000001

-- UTILS
function set(key, val)
    setProperty(key, val)
end
function get(key)
    return getProperty(key)
end
function addRel(key, val)
    setProperty(key, getProperty(key) + val)
end

function onCreate()
	-- background shit
	makeLuaSprite('background', 'stages/bridge/normal/W2background', -1400, -1400);
	setScrollFactor('background', 1.1, 1.1);
	scaleObject('bridge', 1, 1);

	makeLuaSprite("crowd")
	setProperty("crowd.visible", false)

	makeLuaSprite('bridge', 'stages/bridge/normal/W2bridge', -1400, -1400);
	setLuaSpriteScrollFactor('bridge', 1.1, 1.1);
	scaleObject('bridge', 1, 1);

	makeLuaSprite('foreground', 'stages/bridge/normal/W2foreground', -1400, -1400);
	setLuaSpriteScrollFactor('W2foreground', 1.1, 1.1);
	scaleObject('W2foreground', 1, 1);

	makeAnimatedLuaSprite('BackC','stages/ace/AceCrowd', -780,-275)
	addAnimationByPrefix('BackC','dance','jam',24,true)
	objectPlayAnimation('BackC','dance',false)
	setScrollFactor('BackC', 1.1, 1.1);

	makeLuaSprite('bgsnow', 'stages/bridge/cold/snowbridge1', -1400, -1400);
	setScrollFactor('bgsnow', 1.1, 1.1);

	makeLuaSprite('snow', 'stages/bridge/cold/snowbackground1', -1400, -1400);
	setScrollFactor('snow', 1.1, 1.1);
	scaleObject('snow', 1, 1);

	makeLuaSprite('icefg', 'stages/bridge/cold/snowforeground1', -1400, -1400);
	setLuaSpriteScrollFactor('icefg', 1, 1);
	scaleObject('icefg', 1, 1);

	addLuaSprite('background', false);
	addLuaSprite('snow', false);
	addLuaSprite('bgsnow', false);
	addLuaSprite("crowd", false)
	addLuaSprite('bridge', false);
	addLuaSprite('BackC', false);
	addLuaSprite('icefg', true);
	addLuaSprite('foreground', true);


	set("bgsnow.alpha", HIDDEN);
	set("snow.alpha", HIDDEN);
	set("icefg.alpha", HIDDEN);
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

function onEvent(ev, v1, v2)
	if ev == "Snowy Stage" then
		set("background.alpha", HIDDEN)
		set("bridge.alpha", HIDDEN)
		set("foreground.alpha", HIDDEN)
		set("bgsnow.alpha", 1)
		set("snow.alpha", 1)
		set("icefg.alpha", 1)
	end
end

