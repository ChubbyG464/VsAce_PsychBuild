-- CONSTANTS
local HIDDEN = 0.0000000001
local backgroundLevel = 2
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
function makeSprite(id, image, x, y)
	local im = image
	if im ~= "" then
		im = ""..im
	end
	makeLuaSprite(id, im, x, y)
	set(id..".active", false)
end

function makeSolid(id, width, height, color)
	makeGraphic(id, 1, 1, color)
	scaleObject(id, width, height)
end

function makeAnimSprite(id, image, x, y, spriteType)
	makeAnimatedLuaSprite(id, ""..image, x, y, spriteType)
end

function setVelocity(tag, x, y)
	setProperty(tag..".velocity.x", x)
	setProperty(tag..".velocity.y", y)
end

function makeSnow(tag, image, velx, vely)
	local im = image
	if im ~= "" then
		im = ""..im
	end
	makeBackdrop(tag, im)
	setScrollFactor(tag, 0.2, 0)
	setVelocity(tag, velx, vely)
	screenCenter(tag)
	set(tag..'.alpha', 1)
	set(tag..".camZoom", 0.5)
end

local lSongName = ""

function onCreate()

	lSongName = string.lower(songName):gsub(" ", "-")

	setPropertyFromClass("PlayState", "currentWrath", "")

	if backgroundLevel > 0 then
		makeLuaSprite('background1', 'stages/ace/Background1', -1400, -1400);
		setScrollFactor('background1', 1.1, 1.1);
		
		makeLuaSprite('Fences', 'stages/ace/Fences', -1922, -1720);
		setScrollFactor('Fences', 1.1, 1.1);
		scaleObject('Fences', 1, 1);
	
		makeLuaSprite('P1Snow1', 'stages/ace/P1Snow1', -1400, -1400);
		setLuaSpriteScrollFactor('P1Snow1', 1.1, 1.1);
		scaleObject('P1Snow1', 1, 1);
	
		makeLuaSprite('Overlay', 'stages/ace/Overlay', -1400, -1400);
		setLuaSpriteScrollFactor('Overlay', 1.1, 1.1);
		scaleObject('Overlay', 1, 1);
	
		makeLuaSprite('Lamps', 'stages/ace/Lamps', -1400, -1400);
		setLuaSpriteScrollFactor('Lamps', 1.1, 1.1);
		scaleObject('Lamps', 1, 1);
	
		makeAnimatedLuaSprite('BackC','stages/ace/Back_Characters', -820,-795)
		addAnimationByPrefix('BackC','dance','bop',24,true)
		objectPlayAnimation('BackC','dance',false)
		setScrollFactor('BackC', 1.1, 1.1);
	
		makeAnimatedLuaSprite('FrontC','stages/ace/Front_Characters', -1285,-610)
		addAnimationByPrefix('FrontC','dance','bop',24,true)
		objectPlayAnimation('FrontC','dance',false)
		setScrollFactor('FrontC', 1.1, 1.1);
	
			
		addLuaSprite('background1', false);
		addLuaSprite('BackC', false);
		addLuaSprite('Fences', false);
		addLuaSprite('P1Snow1', false);
		addLuaSprite('FrontC', false);
		addLuaSprite('Lamps', true);
		addLuaSprite('Overlay', true);
			
	end
end

function onBeatHit()
	objectPlayAnimation("BackC", "dance", true)
	objectPlayAnimation("FrontC", "dance", true)
end

function addBF_X(val)
	addRel("BF_X", val)
	set("boyfriendGroup.x", get("BF_X"))
end
function addBF_Y(val)
	addRel("BF_Y", val)
	set("boyfriendGroup.y", get("BF_Y"))
end

function addGF_X(val)
	addRel("GF_X", val)
	set("gfGroup.x", get("GF_X"))
end
function addGF_Y(val)
	addRel("GF_Y", val)
	set("gfGroup.y", get("GF_Y"))
end

function addDAD_X(val)
	addRel("DAD_X", val)
	set("dadGroup.x", get("DAD_X"))
end
function addDAD_Y(val)
	addRel("DAD_Y", val)
	set("dadGroup.y", get("DAD_Y"))
end

function onCreatePost()
	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)

	local hasSnowEvents = true

	for i = 0, getProperty("eventNotes.length")-1 do
		local name = getPropertyFromGroup("eventNotes", i, "event")
		if name == "Weak Snow" then
			hasSnowEvents = true
		end
		if name == "Mid Snow" then
			hasSnowEvents = true
		end
		if name == "Strong Snow" then
			hasSnowEvents = true
		end
		if name == "Snowstorm" then
			hasSnowEvents = true
		end
		if name == "Strongest Snow" then
			hasSnowEvents = true
		end
	end

	if hasSnowEvents and backgroundLevel > 1 then
		-- Backdrops
		makeSnow('snowfgweak', 'weak', 100, 110)
		makeSnow('snowfgweak2', 'weak2', -100, 110)
		makeSnow('snowfgmid', 'mid', 400, 210)
		makeSnow('snowfgmid2', 'mid2', -400, 210)
		makeSnow('snowfgstrong', 'strong', 900, 410)
		makeSnow('snowfgstrong2', 'strong2', -900, 410)
		makeSnow('snowstorm', 'storm', -5000, 0)
		makeSnow('snowstorm2', 'storm2', -3700, 0)
		makeSnow('snowstorm3', 'storm', -2800, 0)
		makeSnow('snowfgstrongest', 'strongest', -1100, 500)

		set('snowstorm.repeatX', true)
		set('snowstorm.repeatY', false)

		set('snowstorm3.repeatX', true)
		set('snowstorm3.repeatY', false)

		addBackdrop('snowfgweak', true)
		addBackdrop('snowfgweak2', true)

		addBackdrop('snowfgmid', true)
		addBackdrop('snowfgmid2', true)

		addBackdrop('snowfgstrong', true)
		addBackdrop('snowfgstrong2', true)

		addBackdrop('snowstorm', true)
		addBackdrop('snowstorm2', true)
		addBackdrop('snowstorm3', true)

		set("snowstorm.alpha", HIDDEN)
		set("snowstorm2.alpha", HIDDEN)
		set("snowstorm3.alpha", HIDDEN)

		set("snowfgstrong.alpha", HIDDEN)
		set("snowfgstrong2.alpha", HIDDEN)

		set("snowfgstrongest.alpha", HIDDEN)

		addRel('snowstorm.y', -580)
		addRel('snowstorm3.y', -580)

		addBackdrop('snowfgstrongest', true)
	end
end

function onEvent(ev, v1, v2)
	if ev == "Weak Snow" then
		local alpha = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			set("snowfgweak.alpha", alpha)
			set("snowfgweak2.alpha", alpha)
		else
			doTweenAlpha('weak1', 'snowfgweak', alpha, time)
			doTweenAlpha('weak2', 'snowfgweak2', alpha, time)
		end
	elseif ev == "Mid Snow" then
		local alpha = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			set("snowfgmid.alpha", alpha)
			set("snowfgmid2.alpha", alpha)
		else
			doTweenAlpha('mid1', 'snowfgmid', alpha, time)
			doTweenAlpha('mid2', 'snowfgmid2', alpha, time)
		end
	elseif ev == "Snowstorm" then
		local alpha = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			set("snowstorm.alpha", alpha)
			set("snowstorm2.alpha", alpha)
			set("snowstorm3.alpha", alpha)
		else
			doTweenAlpha('storm1', 'snowstorm', alpha, time)
			doTweenAlpha('storm2', 'snowstorm2', alpha, time)
			doTweenAlpha('storm3', 'snowstorm3', alpha, time)
		end
	elseif ev == "Strong Snow" then
		local alpha = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			set("snowfgstrong.alpha", alpha)
			set("snowfgstrong2.alpha", alpha)
		else
			doTweenAlpha('strong1', 'snowfgstrong', alpha, time)
			doTweenAlpha('strong2', 'snowfgstrong2', alpha, time)
		end
	elseif ev == "Strongest Snow" then
		local alpha = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			set("snowfgstrongest.alpha", alpha)
		else
			doTweenAlpha('strong3', 'snowfgstrongest', alpha, time)
		end
	elseif ev == "Slow Zoom" then
		local zoom = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			cancelTween("zoomx")
			setProperty("zoom.x", zoom)
		else
			doTweenX('zoomx', 'zoom', zoom, time)
		end
	end
end