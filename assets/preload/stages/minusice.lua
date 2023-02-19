-- CONSTANTS
local bgX = -1100
local bgY = -1350
local scr = 1.1
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

local lSongName = ""

function onCreate()

	lSongName = string.lower(songName):gsub(" ", "-")

	setPropertyFromClass("PlayState", "currentWrath", "")

	if backgroundLevel > 0 then

		makeLuaSprite('bg', 'stages/minus/minusice', bgX, bgY)
		setScrollFactor('bg', scr, scr)
		addLuaSprite('bg')


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
	scaleObject("dad", 1.1, 1.1, false)
	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)
end