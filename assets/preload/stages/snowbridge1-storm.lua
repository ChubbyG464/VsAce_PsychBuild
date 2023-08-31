
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
	makeLuaSprite('iceolation', 'stages/iceo/iceolation', -1400, -1400);
	setScrollFactor('iceolation', 1.1, 1.1);
	scaleObject('iceolation', 1, 1);

	addLuaSprite('iceolation', false);


	makeLuaSprite('purpleMultiply', '', -800, -800)
	-- makeGraphic('purpleMultiply', 1, 1, '0xffa087ca');
	runHaxeCode([[
   	  game.modchartSprites.get("purpleMultiply").makeGraphic(1, 1, 0xFFbdb0d4);
   	  game.modchartSprites.get("purpleMultiply").antialiasing = false;
	]])
	scaleObject('purpleMultiply', 4100, 2200);
	setScrollFactor('purpleMultiply', 0, 0);
	setBlendMode('purpleMultiply', 'multiply');

	addLuaSprite('purpleMultiply', true);

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