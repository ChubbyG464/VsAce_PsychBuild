
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
	makeLuaSprite('iceolation', 'stages/iceo/iceolation2', -1250, -1100);
	setScrollFactor('iceolation', 1.1, 1.1);
	scaleObject('iceolation', 1.2, 1.2);

	addLuaSprite('iceolation', false);


end

function onCreatePost()
	scaleObject("dad", 1.2, 1.2, false)

	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)
	close(true)
end