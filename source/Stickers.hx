package;

import flixel.util.FlxSave;
import flixel.FlxG;

class Stickers {
	public static function save() {
		FlxG.save.data.newSongs = newSongs;
		FlxG.save.data.newMenuItem = newMenuItem;

		FlxG.save.flush();
	}

	public static var init = false;

	public static function load() {
		if(FlxG.save != null) {
			if(!init) {
				#if debug
				FlxG.console.registerClass(Stickers);
				#end
				init = true;
			}

			//FlxG.save.data.newSongs = null;
			//FlxG.save.data.newMenuItem = null;
			//FlxG.save.data.lastPlushiesLink = null;
			//FlxG.save.data.didFirstBoot = null;
			if (FlxG.save.data.newSongs != null) newSongs = FlxG.save.data.newSongs;
			if (FlxG.save.data.newMenuItem != null) newMenuItem = FlxG.save.data.newMenuItem;

			if(FlxG.save.data.didFirstBoot == null) {
				setNew(MENU_ITEM, "freeplay");
				FlxG.save.data.didFirstBoot = true;
				save();
			}
		}
	}

	public static function playedSong(value:String) {
		value = Paths.formatToSongPath(value);

		newSongs.remove(value);
		save();
	}

	private static function add(arr:Array<String>, value:String):Bool {
		if(!arr.contains(value)) {
			arr.push(value);
			return true;
		}
		return false;
	}

	public static var newSongs:Array<String> = [
		"sweater-weather",
		"frostbite-two",
		"preseason-remix",
		"running-laps",
		"icing-tensions",
		"chill-out",
		"no-homo"
	];
	public static var newMenuItem:Array<String> = [];

	public static function setNew(type:UnlockType, value:String) {
		value = Paths.formatToSongPath(value);

		var didAdd = switch(type) {
			case SONG: add(newSongs, value);
			case MENU_ITEM: add(newMenuItem, value);
			default: false;
		}

		return didAdd;
	}

	private static inline function clearArr(array:Array<String>) {
		array.splice(0, array.length);
	}
}

enum abstract UnlockType(Int) {
	var BF = 0;
	var GF = 1;
	var FOE = 2;
	var WEEK = 3;
	var SONG = 4;
	var MODE = 5;
	var CHAR = 6;

	// Unused in unlocks
	var MENU_ITEM = 7;
}