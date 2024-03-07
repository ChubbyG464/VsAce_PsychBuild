import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxGame;

import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.Event;

#if CRASH_HANDLER
import Discord.DiscordClient;

import haxe.CallStack;
import haxe.io.Path;

import lime.app.Application;

import openfl.events.UncaughtErrorEvent;

import sys.FileSystem;
import sys.io.File;
#end

import states.TitleState;

using StringTools;


class Main extends Sprite
{
	public var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	public var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).

	public var zoom:Float = 1.0; // If -1, zoom is automatically calculated to fit the window dimensions.

	public static var framerate:Int = 60;

	public static final fpsDisplay:FPS = new FPS(10, 3, 0xFFFFFF);


	// You can pretty much ignore everything from here on - your code should go in your states.

	/**
	 * Instatiates Main
	 */
	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}


	/**
	 * Entry point for program execution
	 */
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	/**
	 * Initializes an even listener?
	 * @param E 
	 */
	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	/**
	 * Sets up all the game attributes and instantiates FlxGame
	 */
	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			zoom = Math.min(stageWidth / gameWidth, stageHeight / gameHeight);

			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, TitleState, zoom, framerate, framerate, true, false));

		ClientPrefs.loadDefaultKeys();

		#if mac
		// "+" key not working fix for macos
		@:privateAccess FlxG.keys._nativeCorrection.set("0_43", FlxKey.PLUS);
		#end

		#if !mobile
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		fpsDisplay.visible = ClientPrefs.showFPS;

		addChild(fpsDisplay);
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: "
			+ e.error
			+ "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
