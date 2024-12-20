package states.substates;


import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import data.WeekData;

import sprites.Boyfriend;


class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;
	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';
	public static var cameraOffset:FlxPoint = new FlxPoint();

	public static var instance:GameOverSubstate;

	public static function resetVariables() : Void {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
		cameraOffset.set(0, 0);
	}

	override function create() : Void
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	var center = new FlxPoint();

	public function new(x:Float, y:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		boyfriend = new Boyfriend(x, y, characterName);
		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		add(boyfriend);

		// i hate centering so much
		if(characterName == "bf-playerace")
			cameraOffset.y -= 100;
		if(characterName == "bf-retry")
			cameraOffset.x -= 35;

		boyfriend.playAnim('firstDeath');
		boyfriend.updateHitbox();

		var posx = boyfriend.x;
		var posy = boyfriend.y;
		boyfriend.screenCenter();
		center.set(boyfriend.x, boyfriend.y);

		camFollow = new FlxPoint(boyfriend.x + boyfriend.width / 2, boyfriend.y + boyfriend.height / 2);

		boyfriend.setPosition(posx, posy);
		boyfriend.playAnim('firstDeath', true); // reset offset
		center.add(boyfriend.offset.x, boyfriend.offset.y);

		FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(100);
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(
			FlxG.camera.scroll.x + (FlxG.camera.width / 2),
			FlxG.camera.scroll.y + (FlxG.camera.height / 2)
		);
		add(camFollowPos);
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float) : Void
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(
				FlxMath.lerp(camFollowPos.x, camFollow.x + cameraOffset.x, lerpVal),
				FlxMath.lerp(camFollowPos.y, camFollow.y + cameraOffset.y, lerpVal)
			);
			boyfriend.setPosition(
				FlxMath.lerp(boyfriend.x, center.x, lerpVal),
				FlxMath.lerp(boyfriend.y, center.y, lerpVal)
			);
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			WeekData.loadTheFirstEnabledMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				coolStartDeath();
				boyfriend.startedDeath = true;
				playingDeathSound = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit() : Void
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
