package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;

class ZeroEndingState extends FlxSubState {
	var zeroEndBG:FlxSprite;
	var zeroEndingGroup:FlxTypedGroup<FlxSprite>;
	var zeroCardGroup:FlxTypedGroup<FlxSprite>;
	var background:FlxSpriteExtra;
	var enterPressedOnce:Bool = false;

	override function create() {
		zeroEndBG = new FlxSprite(0, 0).loadGraphic(Paths.image("images/stages/ace/End"));
		zeroEndBG.scrollFactor.set();
		zeroEndBG.antialiasing = ClientPrefs.globalAntialiasing;
		zeroEndBG.screenCenter();
		zeroEndBG.alpha = 0;
		zeroEndBG.scale.set(0.7, 0.7);
		add(zeroEndBG);

		background = new FlxSpriteExtra(0,0).makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
		background.scrollFactor.set();
		background.alpha = 0;
		add(background);

		FlxTween.tween(zeroEndBG, {alpha: 1},1);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		cameras[0].angle = 0;

		super.create();
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ENTER) {
			if (enterPressedOnce/* || PlayState.finishedzero*/) {
				//SaveDataManager.instance.endingData.setFinishedzeroFlag(true);
				if(FlxG.sound.music != null) {
					FlxG.sound.music.persist = true;
				}
				MusicBeatState.nextGhostAllowed = true;
			//	MusicBeatState.songLoadingScreen = "loading";
				MusicBeatState.switchState(new StoryMenuState());
			}
			else {
				FlxTween.tween(background, {alpha: 0.6},1);
				enterPressedOnce = true;
			}
		}
	}

	/*  (Arcy)
	*   Function used to tween the alpha of every sprite in the group to 0. Also sets stopspamming to false when done.
	*   @param  group               The group of FlxSprites to fade out by tweening the alpha of each sprite to 0.
	*   @param  alphaVal            The alpha for the group of FlxSprites to fade to.
	*   @param  stopSpammingFlag    Set to true if the stopspamming flag should be set to false when the tweens are complete.
	*/
	function fadeGroup(group:FlxTypedGroup<FlxSprite>, alphaVal:Float, callback:Null<TweenCallback>)
	{
		if (callback != null)
		{
			// (Arcy) This is odd to do, but it will reduce the amount of function creations and calls
			var firstMember = group.members[0];
			FlxTween.tween(firstMember, {alpha: alphaVal}, 1, {ease: FlxEase.cubeInOut, onComplete: callback});
			group.remove(firstMember);

			for (spr in group)
			{
				FlxTween.tween(spr, {alpha: alphaVal}, 1, {ease: FlxEase.cubeInOut});
			}

			group.insert(0, firstMember);
		}
		else
		{
			for (spr in group)
			{
				FlxTween.tween(spr, {alpha: alphaVal}, 1, {ease: FlxEase.cubeInOut});
			}
		}
	}
}