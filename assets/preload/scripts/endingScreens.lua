local lSongName = ""
local endScreen = false
local notSeen = true

local simpleStory = {
	["sub-zero"] = { loop='endLoop', img='End', music='end', dialogue={"dialogue2", 'dialogue-retro2', 'dialogue-ace2'}, dialogueMusic="dialogueAmbience1", story=true},
	["cryogenic"] = { loop='endLoop', img='End2', music='end2', dialogue={"dialogue2", 'dialogue-retro2', 'dialogue-ace2'}, dialogueMusic="dialogueAmbience2", story=true},

	["ectospasm"] = { loop='endLoop', img='EctospasmEnd', music='endzer', dialogue="dialogueEnd" },
	["cold-hearted"] = { loop='endLoop', img='SakuGetsCockblocked', music='endsak', dialogue="dialogueEnd" },
	["sweater-weather"] = { dialogue="dialogueEnd" },
	["frostbite-two"] = { dialogue="dialogueEnd" },
}

local function istable(t) return type(t) == 'table' end

function onCreatePost()
	lSongName = string.lower(songName):gsub(" ", "-")

	if simpleStory[lSongName] == nil then
		close(true)
		return
	end

	if simpleStory[lSongName].story and not isStoryMode then
		close(true)
		return
	end

	--luaDebugMode = true

	makeLuaSprite("endScreen")
	setProperty("endScreen.active", false)

	runHaxeCode([[
		controls = game.controls;
	]])
end

totalPages = -1

function simpleEndScreen(story)
	runHaxeCode([[
		fade = new FlxSprite(0, 0).makeGraphic(1, 1, 0xFF000000);
		fade.setGraphicSize(1280*3, 720*3);
		fade.updateHitbox();
		fade.alpha = 0.0001;
		fade.cameras = [game.camOther];
		fade.screenCenter();
		endImage = new FlxSprite(0, 0).loadGraphic(Paths.image("dialogue/]]..story.img..[["));
		endImage.alpha = 0.0001;
		endImage.cameras = [game.camOther];
		endImage.screenCenter();
		endImage.antialiasing = true;

		game.dialogueCount = 0;

		game.psychDialogue.finishThing = function() {
			game.psychDialogue = null;

			game.add(fade);
			FlxTween.tween(fade, {alpha: 1}, 1, {
				onComplete: function(flx:FlxTween) {
					game.add(endImage);
					endMusic = new FlxSound().loadEmbedded(Paths.music("]]..story.music..[["), false, true);
					endMusic.play(true);
					FlxG.sound.list.add(endMusic);
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
		};
		trace("After");
	]])

	--totalPages = getProperty("psychDialogue.dialogueList.dialogue.length") - 1
end

--function onNextDialogue(count)
--	debugPrint(count, " ", totalPages)
--	if count == totalPages then -- Wtf i cant assign finishThing without it running early
--		runHaxeCode([[
--			trace(game.psychDialogue);
--
--			/*function onFinishDialogue() {
--
--			}*/
--
--			//game.psychDialogue.finishThing = onFinishDialogue;
--			//game.psychDialogue.finishThing = () -> {
--			//	trace("finishThing");
--			//};
--		]])
--	end
--end

function onUpdatePost(elapsed)
	if getProperty("endScreen.active") then
		runHaxeCode([[
		if ((controls.PAUSE || controls.ACCEPT) && game.endingSong)
		{
			trace('im sad this is sad');
			game.transIn = FlxTransitionableState.defaultTransIn;
			game.transOut = FlxTransitionableState.defaultTransOut;

			game.paused = true;
			game.camHUD.visible = true;

			FlxG.sound.music.stop();
			game.vocals.stop();
			if (endMusic.playing)
			{
				endMusic.fadeOut(1, 0, function(flx:FlxTween)
				{
					endMusic.stop();
					game.endSong();
				});
				endMusic.onComplete = null;
			}
			else {
				endLoop.fadeOut(1, 0, function(flx:FlxTween)
				{
					endLoop.stop();
					game.endSong();
				});
			}
		}
	]])
	end
end

function onEndSong()
	if notSeen then
		notSeen = false;
		--runTimer('ending', 0.8);

		story = simpleStory[lSongName]

		if not istable(story.dialogue) then
			story.dialogue = story.dialogue:gsub("bfVersion", getProperty("bfVersion"))
			story.dialogue = story.dialogue:gsub("dadVersion", getProperty("SONG.player2"))
			story.dialogue = story.dialogue:gsub("gfVersion", getProperty("SONG.gfVersion"))
		end

		doTweenAlpha("camHUD", "camHUD", 0, 0.3)

		addHaxeLibrary("FlxSound", "flixel.system")
		addHaxeLibrary("FlxTransitionableState", "flixel.addons.transition")

		if story.loop then
			runHaxeCode([[
				endLoop = new FlxSound().loadEmbedded(Paths.music(']]..story.loop..[['), true, true);

				FlxG.sound.list.add(endLoop);
			]])
		end

		setProperty("canPause", false)

		if istable(story.dialogue) then
			if getProperty("bfVersion") == "bf-retro" then
				startDialogue(story.dialogue[2], story.dialogueMusic)
			elseif getProperty("bfVersion") == "bf-ace" then
				startDialogue(story.dialogue[3], story.dialogueMusic)
			else
				startDialogue(story.dialogue[1], story.dialogueMusic)
			end
		else
			startDialogue(story.dialogue, story.dialogueMusic)
		end
		if story.music and story.img then
			simpleEndScreen(story)
		end
		setObjectCamera("psychDialogue", "other")
		--runHaxeCode([[
		--	game.psychDialogue.cameras = [game.camOther];
		--]])
		return Function_Stop;
	end

	return Function_Continue;
end