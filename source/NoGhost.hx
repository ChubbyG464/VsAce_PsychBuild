#if windows
@:headerCode('
#include "windows.h"
#include "winuser.h"
')
@:unreflective
@:nativeGen
#end
class NoGhost {
	#if windows
	@:functionCode('
	DisableProcessWindowsGhosting();
	')
	#end
	public static function disable():Void {}
}