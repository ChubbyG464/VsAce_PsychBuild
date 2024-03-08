package data;


import flixel.util.FlxSave;
import flixel.FlxG;

class Unlocks {
	// Changable Characters
	public static var bfName:String = "";

	// Full
	public static var allBfs:Array<String> = [
		"bf",
		"bf-retro",
		"bf-ace",
	];

	public static var allWeeks:Array<String> = [
		"week0",
		"week1",
		"week2",
	];

	// Songs

	public static var allSongs:Array<String> = [
		"concrete-jungle",
		"noreaster",
		"sub-zero",
		"frostbite",
		"groundhog-day",
		"cold front",
		"cryogenic",
		"north",
		"cold-hearted",
		"ectospasm",
		"running-laps",
		"icing-tensions",
		"chill-out",
		"no-homo",
		"sweater-weather",
		"frostbite-two",
		"preseason-remix",
	];

	// Save data
	public static var unlockedWeeks:Array<String> = [
		"Extras1",
		"Extras2",
		"Extras3",
	];


	public static var unlockedBfs:Array<String> = [
		"bf",
		//#if debug
		//"bf-retro",
		//"bf-ace",
		//"bf-minus",
		//"bf-saku",
		//#end
	];
	public static var unlockedGfs:Array<String> = [
		"gf",
		//#if debug
		//"gf-minus",
		//"gf-saku",
		//"gf-ace",
		//"gf-zerktro",
		//"gf-saku-goth",
		//#end
	];
	// Change this to be in the savedata later, this is just for testing currently

	private static var hasLoadedDefault:Bool = false;
	public static var isReset(get, never):Bool;

	private static function get_isReset() : Bool {
		var u = [];
		var d = [];
		u.push(unlockedSongs.join("|"));
		u.push(unlockedWeeks.join("|"));
		u.push(unlockedBfs.join("|"));

		d.push(defaultSongs.join("|"));
		d.push(defaultWeeks.join("|"));
		d.push(defaultBfs.join("|"));
		return u.join(";") == d.join(";");
	}

	public static var defaultSongs:Array<String> = [];
	public static var defaultWeeks:Array<String> = [];
	public static var defaultBfs:Array<String> = [];

	private static function defaultSetup() : Void {
		if(hasLoadedDefault) {
			return;
		}

		defaultSongs = unlockedSongs.copy();
		defaultWeeks = unlockedWeeks.copy();
		defaultBfs = unlockedBfs.copy();

		hasLoadedDefault = true;
	}

	public static function resetProgress() : Void {
		unlockedSongs = defaultSongs;
		unlockedWeeks = defaultWeeks;
		unlockedBfs = defaultBfs;
	}

	public static function saveUnlocks() : Void {
		fixOrder();

		var save:FlxSave = new FlxSave();
		save.bind("vsacev3-unlocks", "Friday Night Funkin': Vs Ace-Psych");

		save.data.bfs = unlockedBfs;
		save.data.weeks = unlockedWeeks;
		save.data.songs = unlockedSongs;

		save.data.newSongs = newSongs;
		save.data.newWeeks = newWeeks;
		save.data.newMenuItem = newMenuItem;

		save.flush();
		save.close();
	}

	public static var init = false;
	public static var portedFromOld = false;
	public static var firstBoot = false;

	public static function loadUnlocks() : Void {
		defaultSetup();

		var save:FlxSave = new FlxSave();
		save.bind("vsacev3-unlocks", "Friday Night Funkin': Vs Ace-Psych");
		if(save != null) {
			if(!init) {
				#if debug
				FlxG.console.registerClass(Unlocks);
				#end
				init = true;
			}
			if (save.data.bfs != null) unlockedBfs = save.data.bfs;
			if (save.data.weeks != null) unlockedWeeks = save.data.weeks;
			if (save.data.songs != null) unlockedSongs = save.data.songs;

			if (save.data.newSongs != null) newSongs = save.data.newSongs;
			if (save.data.newWeeks != null) newWeeks = save.data.newWeeks;
			if (save.data.newMenuItem != null) newMenuItem = save.data.newMenuItem;

			if(firstBoot) {
				setNew(MENU_ITEM, "options");
				setNew(MENU_ITEM, "freeplay");
				saveUnlocks();
			}
			if(portedFromOld) {
				setNew(MENU_ITEM, "options");
				setNew(MENU_ITEM, "credits");
				saveUnlocks();
			}
			progressCheck();
		}
		save.close();
	}

	// Unlock Utils

	public static var recentlyUnlockedChars:Array<String> = [];
	//public static var recentlyUnlockedBfs:Array<String> = [];
	//public static var recentlyUnlockedGfs:Array<String> = [];
	//public static var recentlyUnlockedFoes:Array<String> = [];
	public static var recentlyUnlockedWeeks:Array<String> = [];
	public static var recentlyUnlockedSongs:Array<String> = [];

	public static function finishedStoryWeek(weekName:String) : Void {
		if(weekName == "week0") {
		}
	}

	/** (Arcy)
	* Determines any content that should be unlocked after the specified song ends.
	* @param song   The name of the song to check for unlocked content.
	**/
	public static function finishedSong(song:String) : Void {
		// (Arcy) Other special unlocks for completion of songs
		switch (song)
		{
			case 'sub-zero':
				if (!hasUnlockedSong('frostbite'))
				{
					unlock(BF, 'bf-ace');
					unlock(BF, 'bf-retro');
					//saveDataManager.newContent.setFreeplayFlag(true, saveDataManager.unlockData.getSongIndex('Ectospasm'));
					setNew(SONG, "frostbite");
					unlock(SONG, "frostbite");
				}
			case 'cryogenic':
				if (!hasUnlockedSong('north'))
				{
					setNew(SONG, "north");
					unlock(SONG, "north");
					setNew(SONG, "cold-hearted");
					unlock(SONG, "cold-hearted");
					setNew(SONG, "ectospasm");
					unlock(SONG, "ectospasm");
					saveUnlocks();
				}
			case 'no-homo':
				if (!hasUnlockedSong('sweater-weather'))
				{
					setNew(SONG, "sweater-weather");
					unlock(SONG, "sweater-weather");
					setNew(SONG, "frostbite-two");
					unlock(SONG, "frostbite-two");
					setNew(SONG, "preseason-remix");
					unlock(SONG, "preseason-remix");
					saveUnlocks();
				}
			
			}
		//saveUnlocks();
		}
	
	public static function progressCheck() : Void {
		fixOrder();
	}

	public static function playedSong(value:String) : Void {
		value = Paths.formatToSongPath(value);

		if(!unlockedSongs.contains(value)) {
			unlockedSongs.push(value);

			unlockedSongs = _fixOrder(unlockedSongs, allSongs);

			trace("PLAYED: " + value);
		}

		newSongs.remove(value);
		saveUnlocks();
	}

	private static function add(arr:Array<String>, value:String):Bool {
		if(!arr.contains(value)) {
			arr.push(value);
			return true;
		}
		return false;
	}

	public static function unlock(type:UnlockType, _value:String, hidden:Bool = false) : Bool {
		var value = Paths.formatToSongPath(_value);

		var didAdd = switch(type) {
			case BF: add(unlockedBfs, value);
			case WEEK: add(unlockedWeeks, value);
			case SONG: add(unlockedSongs, value);
			default: false;
		}

		trace("UNLOCKED:", type, value, hidden, didAdd);

		if(didAdd && !hidden) {
			switch(type) {
				case BF: recentlyUnlockedChars.push(value);//recentlyUnlockedBfs.push(value);
				case WEEK: recentlyUnlockedWeeks.push(value);
				case SONG: recentlyUnlockedSongs.push(_value);
				default:{};
			}
		}
		saveUnlocks();
		return didAdd;
	}

	public static var newWeeks:Array<String> = ["week2"];
	public static var newSongs:Array<String> = [
		"sweater-weather",
		"frostbite-two",
		"preseason-remix",
	];
	public static var newMenuItem:Array<String> = [];

	public static function setNew(type:UnlockType, value:String) : Bool {
		value = Paths.formatToSongPath(value);

		var didAdd = switch(type) {
			case WEEK: add(newWeeks, value);
			case SONG: add(newSongs, value);
			case MENU_ITEM: add(newMenuItem, value);
			default: false;
		}

		return didAdd;
	}

	private static inline function clearArr(array:Array<String>) : Void {
		array.splice(0, array.length);
	}

	public static function clearRecentType(type:UnlockType) : Void {
		switch(type) {
			case BF: clearArr(recentlyUnlockedChars);
			case WEEK: clearArr(recentlyUnlockedWeeks);
			case SONG: clearArr(recentlyUnlockedSongs);
			default:{};
		}
	}

	// Utils

	public static function fixOrder() : Void {
		unlockedBfs = _fixOrder(unlockedBfs, allBfs);
		unlockedSongs = _fixOrder(unlockedSongs, allSongs);
		unlockedWeeks = _fixOrder(unlockedWeeks, allWeeks);
	}

	private static function _fixOrder(unlocked:Array<String>, all:Array<String>) : Array<String> {
		var newList:Array<String> = [];
		for(data in all) {
			if(unlocked.contains(data)) {
				newList.push(data);
			}
		}
		return newList;
	}

	public inline static function isBFUnlocked(name:String) : Bool {
		return Unlocks.unlockedBfs.contains(name);
	}
	public inline static function isBFUnlockedIdx(idx:Int) : Bool {
		return Unlocks.unlockedBfs.contains(Unlocks.allBfs[idx]);
	}

	public inline static function isWeekUnlocked(week:String) : Bool {
		if(!Unlocks.allWeeks.contains(week)) return true; // Assume Custom Week
		return Unlocks.unlockedWeeks.contains(week);
	}

	public static var debugAllSongs:Bool = false;

	public static function hasUnlockedSong(song:String) : Bool {
		if(Unlocks.debugAllSongs) return true;
		song = Paths.formatToSongPath(song);
		if(!Unlocks.allSongs.contains(song)) return true; // Assume Custom Song
		return Unlocks.unlockedSongs.contains(song);
	}
}

enum abstract UnlockType(Int) {
	var BF = 0;
	var WEEK = 1;
	var SONG = 2;

	// Unused in unlocks
	var MENU_ITEM = 7;
}