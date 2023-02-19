function onCreate()
	-- background shit
	makeLuaSprite('background', 'stages/bridge/normal/W2background', -1400, -1400);
	setScrollFactor('background', 1.1, 1.1);
	scaleObject('bridge', 1, 1);

	makeLuaSprite('bridge', 'stages/bridge/normal/W2bridge', -1400, -1400);
	setLuaSpriteScrollFactor('bridge', 1.1, 1.1);
	scaleObject('bridge', 1, 1);

	makeLuaSprite('foreground', 'stages/bridge/normal/W2foreground', -1400, -1400);
	setLuaSpriteScrollFactor('W2foreground', 1.1, 1.1);
	scaleObject('W2foreground', 1, 1);



	addLuaSprite('background', false);
	addLuaSprite('bridge', false);
	addLuaSprite('foreground', true);

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

