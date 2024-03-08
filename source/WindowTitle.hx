import openfl.Lib;

class WindowTitle {
	public static var DEFAULT(get, null):String = "";

	public static function changeTitle(text:String) : Void {
		Lib.application.window.title = text;
	}

	public static function progress(_progress:Int) : Void {
		var progress:Float = _progress / 100;
		var length = 10;
		var act = "#";
		var unt = "_";

		var str = "[";

		var filled = Math.floor(length * progress);

		for(i in 0...filled) {
			str += act;
		}
		for(i in 0...length-filled) {
			str += unt;
		}
		str += "]";

		Lib.application.window.title = DEFAULT + " - " + str;
	}
	public static inline function defaultTitle() : Void {
		changeTitle(DEFAULT);
	}

	static function get_DEFAULT() : String {
		if(DEFAULT == "") {
			DEFAULT = Lib.application.meta["name"];
		}
		return DEFAULT;
	}
}