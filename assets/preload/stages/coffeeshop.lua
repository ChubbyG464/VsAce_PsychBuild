function onCreate()
	-- background shit
	makeLuaSprite('coffeeshop', 'coffeeshop', -100, -100);
	setLuaSpriteScrollFactor('coffeeshop', 0.2, 0.2);
	scaleObject('coffeeshop', 0.48, 0.48)
	

	addLuaSprite('coffeeshop', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end