package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<MenuItem>;
	var visualMenuItems:FlxTypedGroup<MenuItem>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'options',
		'credits',
		'plushies',
	];
	public static var firstStart:Bool = true;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	public static var finishedFunnyMove:Bool = false;

	var currentPlushieCampaign:String = "https://www.makeship.com/products/mace-plush";

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGBlue'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		add(magenta);

		var http = new haxe.Http("https://raw.githubusercontent.com/KamexVGM/VsAce-Internet-Stuff/main/plushies.txt");

		http.onData = function(data:String)
		{
			currentPlushieCampaign = data.replace("\n", "").replace("\r", "").trim();
			trace("Current Plushie Link: " + currentPlushieCampaign);
			if(currentPlushieCampaign != "") {
				if(FlxG.save.data.lastPlushiesLink != currentPlushieCampaign) {
					Stickers.newMenuItem.push("plushies");
					FlxG.save.data.lastPlushiesLink = currentPlushieCampaign;
				}
			}
		}

		http.onError = function (error) {
			trace('http error: $error');
		}

		http.request();

		if(currentPlushieCampaign == "" || currentPlushieCampaign.length < 2) {
			optionShit.remove("plushies");
		}
		
		// magenta.scrollFactor.set();

		var black:FlxSprite = new FlxSprite(-300).loadGraphic(Paths.image('blackFade'));
		black.scrollFactor.x = 0;
		black.scrollFactor.y = 0;
		black.setGraphicSize(Std.int(black.width * 1.1));
		black.updateHitbox();
		//black.screenCenter();
		black.antialiasing = ClientPrefs.globalAntialiasing;
		add(black);
		if (firstStart) {
			FlxTween.tween(black,{x: -100}, 1.4, {ease: FlxEase.expoInOut});
		} else {
			black.x = -100;
		};
	
		menuItems = new FlxTypedGroup<MenuItem>();
		visualMenuItems = new FlxTypedGroup<MenuItem>();
		add(visualMenuItems);

		var stickerItems = new FlxTypedGroup<AttachedSprite>();
		add(stickerItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/


		var icon = new HealthIcon("ace", true);
		icon.x = FlxG.width * 1.1;
		icon.y = FlxG.height * 0.8;
		if(ClientPrefs.globalAntialiasing)
			icon.antialiasing = true;
		icon.updateHitbox();
		add(icon);
		if (firstStart) {
			FlxTween.tween(icon,{x: (FlxG.width * 0.88)}, 1.4, {ease: FlxEase.expoInOut});	
		} else {
			icon.x = FlxG.width * 0.88;
		};

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:MenuItem = new MenuItem(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;

			var option = optionShit[i];

			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + option);
			menuItem.animation.addByPrefix('idle', option + " basic", 24);
			menuItem.animation.addByPrefix('selected', option + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			visualMenuItems.add(menuItem);

			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.updateHitbox();

			menuItem.y = 70 + (i * 160);
			var xVal = 30 + (i * 45);
			if (firstStart) {
				FlxTween.tween(menuItem, {x: xVal}, 1.4, {ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween)
				{
					finishedFunnyMove = true; 
					changeItem();
				}});
			} else {
				menuItem.x = xVal;
			}

			if(Stickers.newMenuItem.contains(option.replace("_", "-"))) {
				var newSticker:AttachedSprite = new AttachedSprite(/*menuItem.width + 300, FlxG.height * 1.6*/);
				newSticker.frames = Paths.getSparrowAtlas('new_text', 'preload');
				newSticker.animation.addByPrefix('Animate', 'NEW', 24);
				newSticker.animation.play('Animate');
				newSticker.scrollFactor.set();
				newSticker.scale.set(0.66, 0.66);
				newSticker.updateHitbox();
				newSticker.sprTracker = menuItem;
				newSticker.xAdd = menuItem.width - newSticker.width/2;
				newSticker.yAdd = -newSticker.height/2;
				newSticker.copyVisible = true;
				newSticker.useFrameWidthDiff = true;
				newSticker.antialiasing = FlxG.save.data.antialiasing;
				stickerItems.add(newSticker);

				menuItem.sticker = newSticker;
			}
		}
		
		icon.angle = -4;

		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			if(icon.angle == -4) 
				FlxTween.angle(icon, icon.angle, 4, 4, {ease: FlxEase.quartInOut});
			if (icon.angle == 4) 
				FlxTween.angle(icon, icon.angle, -4, 4, {ease: FlxEase.quartInOut});
		}, 0);

		firstStart = false;

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin: Vs Ace");
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'plushies')
				{
					CoolUtil.browserLoad(currentPlushieCampaign);
					if(Stickers.newMenuItem.contains("plushies")) {
						Stickers.newMenuItem.remove("plushies");
						Stickers.save();
					}
					var menuItem = menuItems.members[curSelected];
					if(menuItem.sticker != null) {
						menuItem.sticker.exists = false;
					}
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
				spr.updateHitbox();
			}
		});
	}
}

class MenuItem extends FlxSprite {
	public var z:Int = 0;
	public var sticker:AttachedSprite;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		antialiasing = ClientPrefs.globalAntialiasing;
	}
}