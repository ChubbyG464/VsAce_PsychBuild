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
	set(tag..".camZoom", get("defaultCamZoom"))
end

function onCreate()
	debugPrint("AAB", get("defaultCamZoom"))
end

function onCreatePost()
	luaDebugMode = true


	debugPrint("AAA", get("defaultCamZoom"))

	local hasSnowEvents = false
	local hasWeak = false
	local hasMid = false
	local hasStrong = false
	local hasStorm = false
	local hasStrongest = false

	for i = 0, getProperty("eventNotes.length")-1 do
		local name = getPropertyFromGroup("eventNotes", i, "event")
		if name == "Weak Snow" then
			hasSnowEvents = true
			hasWeak = true
		end
		if name == "Mid Snow" then
			hasSnowEvents = true
			hasMid = true
		end
		if name == "Strong Snow" then
			hasSnowEvents = true
			hasStrong = true
		end
		if name == "Snowstorm" then
			hasSnowEvents = true
			hasStorm = true
		end
		if name == "Strongest Snow" then
			hasSnowEvents = true
			hasStrongest = true
		end
	end

	if hasSnowEvents and backgroundLevel > 1 then
		-- Backdrops
		if hasWeak then
			makeSnow('snowfgweak', 'weak', 100, 110)
			makeSnow('snowfgweak2', 'weak2', -100, 110)
			debugPrint("Loaded Weak Snow")

			set("snowfgweak.alpha", HIDDEN)
			set("snowfgweak2.alpha", HIDDEN)
		end
		if hasMid then
			makeSnow('snowfgmid', 'mid', 400, 210)
			makeSnow('snowfgmid2', 'mid2', -400, 210)
			debugPrint("Loaded Mid Snow")

			set("snowfgmid.alpha", HIDDEN)
			set("snowfgmid2.alpha", HIDDEN)
		end
		if hasStrong then
			makeSnow('snowfgstrong', 'strong', 900, 410)
			makeSnow('snowfgstrong2', 'strong2', -900, 410)
			debugPrint("Loaded Strong Snow")

			set("snowfgstrong.alpha", HIDDEN)
			set("snowfgstrong2.alpha", HIDDEN)
		end
		if hasStorm then
			makeSnow('snowstorm', 'storm', -5000, 0)
			makeSnow('snowstorm2', 'storm2', -3700, 0)
			makeSnow('snowstorm3', 'storm', -2800, 0)
			debugPrint("Loaded Storm Snow")

			set('snowstorm.repeatX', true)
			set('snowstorm.repeatY', false)

			set('snowstorm3.repeatX', true)
			set('snowstorm3.repeatY', false)

			set("snowstorm.alpha", HIDDEN)
			set("snowstorm2.alpha", HIDDEN)
			set("snowstorm3.alpha", HIDDEN)
		end
		if hasStrongest then
			makeSnow('snowfgstrongest', 'strongest', -1100, 500)
			debugPrint("Loaded Strongest Snow")

			set("snowfgstrongest.alpha", HIDDEN)
		end

		addBackdrop('snowfgweak', true)
		addBackdrop('snowfgweak2', true)

		addBackdrop('snowfgmid', true)
		addBackdrop('snowfgmid2', true)

		addBackdrop('snowfgstrong', true)
		addBackdrop('snowfgstrong2', true)

		addBackdrop('snowstorm', true)
		addBackdrop('snowstorm2', true)
		addBackdrop('snowstorm3', true)

		addBackdrop('snowfgstrongest', true)
	else
		close(true)
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
	end
end