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
function makeSprite(id, image, x, y)
	local im = image
	if im ~= "" then
		im = ""..im
	end
	makeLuaSprite(id, im, x, y)
	set(id..".active", false)
end

function makeAnimSprite(id, image, x, y, spriteType)
	makeAnimatedLuaSprite(id, ""..image, x, y, spriteType)
end

function makeSolid(id, width, height, color)
	makeGraphic(id, 1, 1, color)
	scaleObject(id, width, height)
end

-- Event

local LEFT = -1
local RIGHT = 1

local info = { -- Key is lowercased and needs to match image name, no uppercase image name
	crowd1 = {
		x = 2350,
		y = -150,
		direction = LEFT
	},
	crowd2 = {
		x = 2350,
		y = -200,
		direction = LEFT
	},
	crowd3 = {
		x = -2300,
		y = -250,
		direction = RIGHT
	},
	crowd4 = {
		x = 2350,
		y = -340,
		direction = LEFT
	},
	crowd5 = {
		x = -2300,
		y = -320,
		direction = RIGHT
	},
	crowd6 = {
		x = -2300,
		y = -330,
		direction = RIGHT
	},
	crowd7 = {
		x = 2350,
		y = -195,
		direction = LEFT
	},
	crowd8 = {
		x = 2350,
		y = -330,
		direction = LEFT
	},
	crowd9 = {
		x = -2300,
		y = -250,
		direction = RIGHT
	}
}

local curDirection = 0

function onCreatePost()

end

function makeCrowd(id)
	-- if runHaxeCode then -- im dumb psych does this automatically
	-- 	runHaxeCode([[
	-- 		var crowd = game.modchartSprites.get("crowd");
	-- 		if(crowd != null) {
	-- 			game.remove(crowd);
	-- 			crowd.destroy();
	-- 		}
	-- 	]])
	-- 	debugPrint("Destroyed")
	-- end
	--removeLuaSprite("crowd")

	id = id:lower()

	local curInfo = info[id]

	curDirection = curInfo.direction

	makeAnimSprite("crowd", id, curInfo.x, curInfo.y)
	addAnimationByPrefix("crowd", 'walk', "walkin", 24, true)
	playAnim("crowd", "walk")
	setScrollFactor("crowd", 0.9, 0.9)
	scaleObject("crowd", 0.35, 0.35, false)

	addLuaSprite("crowd")
	setObjectOrder("crowd", getObjectOrder("bridge"))

	-- crowd.frames = Paths.getSparrowAtlas('crowd9', 'shared');
	-- crowd.animation.addByPrefix('walk', "walkin", 24, true);
	-- crowd.animation.play('walk');
	-- crowd.scrollFactor.set(0.9, 0.9);
	-- crowd.scale.set(0.35, 0.35);
end

local newYorker = false

function onUpdate(elapsed)
	if curDirection ~= 0 then
		addRel("crowd.x", 4 * curDirection * 60 * elapsed)
	end

end

function onEvent(ev, v1, v2)
	if ev == "Crowd" then
		makeCrowd(v1)
	end
end