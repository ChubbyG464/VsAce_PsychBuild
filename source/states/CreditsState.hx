package states;


import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;

#if windows
import Discord.DiscordClient;
#end

using StringTools;


enum Directions
{
	RIGHT;
	UP;
	LEFT;
	DOWN;
}


class Credit extends FlxSpriteGroup
{
	public var nameSprite:FlxTypeText;
	public var twitterSprite:FlxTypeText;
	public var iconSprite:FlxSprite;

	public var highlightColor:FlxColor;

	public var link:String;


	public function new(name:String, twitter:String, iconName:String, highlightColor:FlxColor, link:String)
	{
		super();

		this.highlightColor = highlightColor;
		this.link = link;

		this.nameSprite = new FlxTypeText(0, 0, 0, name);
		this.nameSprite.setFormat("VCR OSD Mono", 24, FlxColor.WHITE);
		this.nameSprite.start(0.1);
		this.add(this.nameSprite);

		this.twitterSprite = new FlxTypeText(0, 20, 0, twitter);
		this.twitterSprite.setFormat("VCR OSD Mono", 18, 0xFFd1d1d1);
		this.twitterSprite.start(0.1);
		this.add(this.twitterSprite);

		this.iconSprite = new FlxSprite(-60, 0);
		this.iconSprite.loadGraphic(Paths.image('crediticons/' + iconName, 'preload'));
		this.iconSprite.setGraphicSize(50, 50);
		this.iconSprite.updateHitbox();
		this.iconSprite.antialiasing = ClientPrefs.globalAntialiasing;
		this.add(this.iconSprite);
	}

	override public function update(elapsed:Float) : Void
	{
		this.iconSprite.setGraphicSize(Std.int(FlxMath.lerp(50, this.iconSprite.width, 0.50)));
		this.iconSprite.updateHitbox();

		super.update(elapsed);
	}

	public function beatHit() : Void
	{
		FlxTween.tween(this.iconSprite, {width: 60, height: 60}, 0.05, {ease: FlxEase.cubeOut});
	}
}


class CreditGroup extends FlxSpriteGroup
{
	public var nameSprite:FlxText;

	public var credits:Array<Credit>;
	public var creditsPerLine:Int = 3;


	public function new(name:String, ?credits:Null<Array<Credit>> = null)
	{
		super();

		this.nameSprite = new FlxText(0, 0, 0, name);
		this.nameSprite.setFormat("VCR OSD Mono", 50, FlxColor.WHITE);
		this.nameSprite.screenCenter(X);
		this.add(this.nameSprite);

		if (credits == null)
		{
			credits = new Array<Credit>();
		}

		this.credits = credits;

		this.arrangeCredits();
	}

	private function arrangeCredits() : Void
	{
		for (creditIndex in 0...this.credits.length)
		{
			var credit:Credit = this.credits[creditIndex];

			credit.screenCenter(X);

			var x:Float = credit.x - 20 + (((creditIndex % this.creditsPerLine) - 1) * 400);
			var y:Float = 75 + (Std.int(creditIndex / this.creditsPerLine) * 80);

			credit.setPosition(x, y);

			this.add(credit);
		}
	}

	public function beatHit() : Void
	{
		for (credit in this.credits)
		{
			credit.beatHit();
		}
	}
}


class CreditPage extends FlxSpriteGroup
{
	public var groups:Array<CreditGroup>;

	public var currentGroup:Int = 0;


	public function new(?groups:Null<Array<CreditGroup>> = null)
	{
		super(0, 150);

		if (groups == null)
		{
			groups = new Array<CreditGroup>();
		}

		this.groups = groups;

		this.arrangeGroups();
	}

	private function arrangeGroups() : Void
	{
		for (groupIndex in 0...this.groups.length)
		{
			var group:CreditGroup = this.groups[groupIndex];

			group.setPosition(0, 300 * (groupIndex % 2));

			this.add(group);
		}
	}

	public function beatHit() : Void
	{
		for (group in this.groups)
		{
			group.beatHit();
		}
	}
}


class CreditsState extends MusicBeatState
{
	public final pages:Array<CreditPage> = [
		new CreditPage([
			new CreditGroup("Artists", [
				new Credit('Aurum', '@AurumArt_', 'aurum', FlxColor.fromRGB(255, 221, 114), 'https://twitter.com/AurumArt_'),
				new Credit('BonesTheSkelebunny01', '@BSkelebunny01', 'bon', FlxColor.fromRGB(255, 51, 187), 'https://twitter.com/BSkelebunny01'),
				new Credit('Dax', '@Daxite_', 'dax', FlxColor.fromRGB(0, 38, 230), 'https://twitter.com/daxite_'),
				new Credit('D6', '@DSiiiiiix', 'd6', FlxColor.fromRGB(107, 104, 120), 'https://twitter.com/DSiiiiiix'),
				new Credit('Kamex', '@KamexVGM', 'kamex', FlxColor.fromRGB(186, 226, 255), 'https://twitter.com/KamexVGM'),
				new Credit('Lectro', '@LectroArt', 'lectro', FlxColor.fromRGB(255, 255, 58), 'https://twitter.com/LectroArt'),
				new Credit('Juno Songs', '@JunoSongsYT', 'juno', FlxColor.fromRGB(191, 0, 230), 'https://twitter.com/JunoSongsYT'),
				new Credit('Pincer', '@PincerProd', 'pincer', FlxColor.fromRGB(25, 255, 255), 'https://twitter.com/PincerProd'),
				new Credit('Shiba Chichi', '@lolychichi', 'chichi', FlxColor.fromRGB(255, 179, 191), 'https://twitter.com/lolychichi'),
				new Credit('Sinna_roll', '@Sinna_roll', 'zhi', FlxColor.fromRGB(204, 255, 102), 'https://twitter.com/Sinna_roll'),
				new Credit('Springy_4264', '@Springy_4264', 'springy', FlxColor.fromRGB(179, 0, 30), 'https://twitter.com/Springy_4264'),
				new Credit('Wildface', '@wildface1010', 'wildface', FlxColor.fromRGB(233, 19, 19), 'https://twitter.com/wildface1010'),
				new Credit('Wolfwrathknight', '@Wolfwrathknight', 'wolf', FlxColor.fromRGB(0, 124, 254), 'https://twitter.com/wolfwrathknight')
			])
		]),
		new CreditPage([
			new CreditGroup("Animators", [
				new Credit('Aurum', '@AurumArt_', 'aurum', FlxColor.fromRGB(255, 221, 114), 'https://twitter.com/AurumArt_'),
				new Credit('Shiba Chichi', '@lolychichi', 'chichi', FlxColor.fromRGB(255, 179, 191), 'https://twitter.com/lolychichi'),
				new Credit('Tenzu', '@Tenzubushi', 'tenzu', FlxColor.GRAY, 'https://twitter.com/Tenzubushi'),
				new Credit('Wildface', '@wildface1010', 'wildface', FlxColor.fromRGB(233, 19, 19), 'https://twitter.com/wildface1010')
			]),
			new CreditGroup("Audio", [
				new Credit('Kamex', '@KamexVGM', 'kamex', FlxColor.fromRGB(186, 226, 255), 'https://twitter.com/kamexvgm')
			])
		]),
		new CreditPage([
			new CreditGroup("Programming", [
				new Credit('ArcyDev', '@AwkwardArcy', 'arcy', FlxColor.fromRGB(255, 140, 25), 'https://twitter.com/AwkwardArcy'),
				new Credit('AyeTSG', '@AyeTSG', 'tsg', FlxColor.fromRGB(120, 114, 114), 'https://twitter.com/ayetsg'),
				new Credit('Candy', '@D0GFREAK', 'candy', FlxColor.fromRGB(255, 192, 203), 'https://twitter.com/D0GFREAK'),
				new Credit('Mk', '@Mkv8Art', 'mk', FlxColor.fromRGB(255, 25, 102), 'https://twitter.com/Mkv8Art'),
				new Credit('Tech', '@ThatTechCoyote', 'tech', FlxColor.fromRGB(153, 0, 0), 'https://twitter.com/ThatTechCoyote'),
				new Credit('Ne_Eo', '@Ne_Eo_Twitch', 'neeo', FlxColor.fromRGB(48, 38, 39), 'https://twitter.com/Ne_Eo_Twitch'),
				new Credit('Tantalun', '@tantalun', 'tantalun', FlxColor.fromRGB(0, 82, 82), 'https://twitter.com/tantalun')
			]),
			new CreditGroup("Charting", [
				new Credit('ChubbyDumpy', '@ChubbyAlt', 'chubby', FlxColor.fromRGB(195, 98, 74), 'https://twitter.com/ChubbyAlt'),
				new Credit('Clipee', '@LilyClipster', 'clip', FlxColor.fromRGB(230, 230, 0), 'https://twitter.com/LilyClipster'),
				new Credit('DJ', '@AlchoholicDj', 'dj', FlxColor.fromRGB(0, 0, 230), 'https://twitter.com/AlchoholicDj')
			])
		]),
		new CreditPage([
			new CreditGroup("Special Thanks", [
				new Credit('RetroSpecter', '@RetroSpecter_', 'retro', FlxColor.fromRGB(23, 216, 228), 'https://twitter.com/Retrospecter_'),
				new Credit('Kade', '@KadeDev', 'kade', FlxColor.fromRGB(25, 77, 0), 'https://twitter.com/kade0912'),
				new Credit('TKTems', '@TKtems', 'tk', FlxColor.fromRGB(0, 230, 191), 'https://twitter.com/TKTems'),
				new Credit('TiredPinkPanda', '@TiredPinkPanda', 'panda', FlxColor.fromRGB(158, 22, 22), 'https://twitter.com/TiredPinkPanda'),
				new Credit('Trackye', '@Trackye', 'track', FlxColor.fromRGB(43, 59, 255), 'https://www.youtube.com/channel/UC4IrLVtl26x-2hb9yYqCyVw'),
				new Credit('Ferzy', '@_Ferzy', 'ferzy', FlxColor.fromRGB(251, 162, 79), 'https://twitter.com/_Ferzy')
			]),
			new CreditGroup("VsAce Psych Port", [
				new Credit('ChubbyDumpy', '@ChubbyAlt', 'chubby', FlxColor.fromRGB(195, 98, 74), 'https://twitter.com/ChubbyAlt'),
				new Credit('Tantalun', '@tantalun', 'tantalun', FlxColor.fromRGB(0, 82, 82), 'https://twitter.com/tantalun'),
				new Credit('Ne_Eo', '@Ne_Eo_Twitch', 'neeo', FlxColor.fromRGB(48, 38, 39), 'https://twitter.com/Ne_Eo_Twitch'),
				new Credit('Mk', '@Mkv8Art', 'mk', FlxColor.fromRGB(255, 25, 102), 'https://twitter.com/Mkv8Art'),
				new Credit('Kamex', '@KamexVGM', 'kamex', FlxColor.fromRGB(186, 226, 255), 'https://twitter.com/KamexVGM')
			])
		])
	];

	var allowInputs:Bool = true;

	private var currentPageIndex:Int = 0;


	override function create() : Void
	{
#if windows
		DiscordClient.changePresence("Reading Credits", null);
#end
		var background:FlxSprite = new FlxSprite();
		background.loadGraphic(Paths.image("menuDesat"));
		background.setGraphicSize(Std.int(background.width * 1.1));
		background.updateHitbox();
		background.screenCenter();
		background.color = 0xFF803fff;
		background.alpha = 0.75;
		background.antialiasing = ClientPrefs.globalAntialiasing;
		this.add(background);

		var title:FlxText = new FlxText(0, 25, 0, 'CREDITS', 100);
		title.setFormat("VCR OSD Mono", 100, FlxColor.WHITE);
		title.screenCenter(X);
		this.add(title);

		var instructions:FlxText = new FlxText(10, 10, 500,
			'Move to select a person\nConfirm to go to their Twitter page\nQ and E to change sections'
		);
		instructions.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, FlxTextAlign.LEFT);
		this.add(instructions);

		for (page in this.pages)
		{
			page.setPosition(0, 2000);
		}

		this.pages[this.currentPageIndex].setPosition(0, 150);

		for (page in this.pages)
		{
			this.add(page);
		}

		super.create();
	}

	override function update(elapsed:Float) : Void
	{
		if (FlxG.sound.music != null)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}

		if (this.controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (this.allowInputs)
		{
			if (FlxG.keys.justPressed.Q)
			{
				this.changePage(Directions.LEFT);
			}

			if (FlxG.keys.justPressed.E)
			{
				this.changePage(Directions.RIGHT);
			}
		}

		super.update(elapsed);
	}

	override function beatHit() : Void
	{
		for (page in this.pages)
		{
			page.beatHit();
		}
	}

	function changePage(direction:Directions) : Void
	{
		if (direction == Directions.UP || direction == Directions.DOWN)
		{
			return;
		}

		allowInputs = false;

		var currentPage:CreditPage = this.pages[currentPageIndex];

		var nextPageIndex:Int = this.currentPageIndex;

		var nextPageStartX:Int = 0;

		if (direction == Directions.RIGHT)
		{
			nextPageStartX = 2000;

			nextPageIndex += 1;

			if (nextPageIndex > this.pages.length - 1)
			{
				nextPageIndex = 0;
			}
		}

		if (direction == Directions.LEFT)
		{
			nextPageStartX = -2000;

			nextPageIndex -= 1;

			if (nextPageIndex < 0)
			{
				nextPageIndex = this.pages.length - 1;
			}
		}

		var nextPage:CreditPage = this.pages[nextPageIndex];

		nextPage.setPosition(nextPageStartX, 150);

		FlxTween.tween(
			currentPage,
			{
				x: (direction == Directions.LEFT ? 2000 : -2000)
			},
			1,
			{
				ease: FlxEase.cubeInOut
			}
		);

		FlxTween.tween(
			nextPage,
			{
				x: 0
			},
			1,
			{
				ease: FlxEase.cubeInOut,
				onComplete: function (flx:FlxTween)
					{
						this.allowInputs = true;
					}
			}
		);

		this.currentPageIndex = nextPageIndex;
	}
}
