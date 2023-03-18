local lSongName = ""
local endScreen = false
local notSeen = true

local simpleStory = {
	["ectospasm"] = { loop='endLoop', img='EctospasmEnd', music='endzer', dialogue="dialogueEnd" }
}

function onCreatePost()
	lSongName = string.lower(songName):gsub(" ", "-")

	if simpleStory[lSongName] == nil then
		close(true)
		return
	end

	luaDebugMode = true

	makeLuaSprite("endScreen")
	setProperty("endScreen.active", false)

	runHaxeCode([[
		controls = game.controls;
	]])
end

function simpleEndScreen(story)
	runHaxeCode([[
		var fade = new FlxSprite(0, 0).makeGraphic(1, 1, 0xFF000000);
		fade.setGraphicSize(1280*3, 720*3);
		fade.updateHitbox();
		fade.alpha = 0.0001;
		fade.cameras = [game.camOther];
		fade.screenCenter();
		endImage = new FlxSprite(0, 0).loadGraphic(Paths.image("]]..story.img..[["));
		endImage.alpha = 0.0001;
		endImage.cameras = [game.camOther];
		endImage.screenCenter();

		trace(game.psychDialogue);

		game.psychDialogue.finishThing = function() {
			game.psychDialogue = null;
			game.add(fade);
			FlxTween.tween(fade, {alpha: 1}, 1, {
				onComplete: function(flx:FlxTween) {
					game.add(endImage);
					endMusic = new FlxSound().loadEmbedded(Paths.music("]]..story.music..[["), false, true);
					endMusic.play(true);
					endMusic.onComplete = function() {
						endMusic.onComplete = null;
						endLoop.play(true);
					}
					FlxTween.tween(endImage, {alpha: 1}, 1, {
						onComplete: function(flx:FlxTween) {
							game.modchartSprites.get("endScreen").active = true;
							//setVar("endScreen", true);
							//game.setOnLuas("endScreen", true);// endScreen = true;
						}
					});
				}
			});
		}
	]])
end

function onUpdatePost(elapsed)
	if getProperty("endScreen.active") then
		runHaxeCode([[
		if ((controls.PAUSE || controls.ACCEPT) && game.endingSong)
		{
			trace('im sad this is sad');
			game.transIn = FlxTransitionablegame.defaultTransIn;
			game.transOut = FlxTransitionablegame.defaultTransOut;

			game.paused = true;
			game.camHUD.visible = true;

			FlxG.sound.music.stop();
			game.vocals.stop();
			if (endMusic.playing)
			{
				endMusic.fadeOut(1, 0, function(flx:FlxTween)
				{
					endMusic.stop();
				});
				endMusic.onComplete = null;
			}
			else {
				endLoop.fadeOut(1, 0, function(flx:FlxTween)
				{
					endLoop.stop();
				});
			}

			game.endSong();
		}
	]])
	end
end

function onEndSong()
	if notSeen then
		debugPrint("playing cutscene")
		notSeen = false;
		--runTimer('ending', 0.8);

		story = simpleStory[lSongName]

		doTweenAlpha("camHUD", "camHUD", 0, 0.3)

		addHaxeLibrary("FlxSound", "flixel.system")

		runHaxeCode([[
			endLoop = new FlxSound().loadEmbedded(Paths.music(']]..story.loop..[['), true, true);

			FlxG.sound.list.add(endLoop);

			game.canPause = false;
		]])
		print(runHaxeCode)
		startDialogue(story.dialogue)
		setObjectCamera("psychDialogue", "other")
		--runHaxeCode([[
		--	game.psychDialogue.cameras = [game.camOther];
		--]])

		simpleEndScreen(story)
		return Function_Stop;
	end

	return Function_Continue;
end