package flixel.system;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class FlxBGSprite extends FlxSprite
{
	public function new()
	{
		super();
		//makeGraphic(1, 1, FlxColor.WHITE, true, FlxG.bitmap.getUniqueKey("bg_graphic_"));
		makeGraphic(1, 1, FlxColor.WHITE, false, "bg_graphic");
		scrollFactor.set();
		moves = false;
	}

	/**
	 * Called by game loop, updates then blits or renders current frame of animation to the screen
	 */
	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		for (camera in cameras)
		{
			if (!camera.visible || !camera.exists)
			{
				continue;
			}

			_matrix.identity();
			_matrix.scale(camera.viewWidth, camera.viewHeight);
			camera.drawPixels(frame, _matrix, colorTransform);

			#if FLX_DEBUG
			FlxBasic.visibleCount++;
			#end
		}
	}

	public function setColor(newColor:FlxColor) {
		color = newColor & 0xFFFFFF;
		alpha = newColor.alpha;
	}
}