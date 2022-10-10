function onCreatePost()
    runHaxeCode([[
snowstorm = new FlxBackdrop(Paths.image('storm'), 0.2, 0, true, false);
            snowstorm.velocity.set(-5000, 0);
            snowstorm.updateHitbox();
            snowstorm.screenCenter();
            snowstorm.alpha = 1;
            snowstorm.antialiasing = ClientPrefs.globalAntialiasing;

snowstorm2 = new FlxBackdrop(Paths.image('storm2'), 0.2, 0, true, true);
            snowstorm2.velocity.set(-3700, 0);
            snowstorm2.updateHitbox();
            snowstorm2.screenCenter();
            snowstorm2.alpha = 1;
            snowstorm2.antialiasing = ClientPrefs.globalAntialiasing;

snowstorm3 = new FlxBackdrop(Paths.image('storm'), 0.2, 0, true, false);
            snowstorm3.velocity.set(-2800, 0);
            snowstorm3.updateHitbox();
            snowstorm3.screenCenter();
            snowstorm3.alpha = 1;
            snowstorm3.antialiasing = ClientPrefs.globalAntialiasing;

PlayState.instance.add(snowstorm);
PlayState.instance.add(snowstorm2);
PlayState.instance.add(snowstorm3);

snowstorm.camZoom = PlayState.instance.defaultCamZoom;
snowstorm2.camZoom = PlayState.instance.defaultCamZoom;
snowstorm3.camZoom = PlayState.instance.defaultCamZoom;
]])
end