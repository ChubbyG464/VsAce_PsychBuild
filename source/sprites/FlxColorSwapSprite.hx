package sprites;


import flixel.system.FlxAssets.FlxShader;
import flixel.graphics.frames.FlxFrame;
import flixel.FlxCamera;
import ColorSwap;
import flixel.FlxSprite;

class FlxColorSwapSprite extends FlxSprite {
	public var colorSwap:CSData;
	public static var staticColorSwap:ColorSwap;

	public function getColorSwap() : ColorSwapShader {
		colorSwap = new CSData();
		if(staticColorSwap == null) {
			staticColorSwap = new ColorSwap();
		}
		return staticColorSwap.shader;
	}

	@:noCompletion
	override function drawComplex(camera:FlxCamera):Void
	{
		_frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());
		_matrix.translate(-origin.x, -origin.y);
		_matrix.scale(scale.x, scale.y);

		if (bakedRotationAngle <= 0)
		{
			updateTrig();

			if (angle != 0)
				_matrix.rotateWithTrig(_cosAngle, _sinAngle);
		}

		_point.add(origin.x, origin.y);
		_matrix.translate(_point.x, _point.y);

		if (isPixelPerfectRender(camera))
		{
			_matrix.tx = Math.floor(_matrix.tx);
			_matrix.ty = Math.floor(_matrix.ty);
		}

		var shdr:FlxShader = shader;
		if(shader == staticColorSwap.shader && colorSwap != null && (colorSwap.hue == 0 && colorSwap.saturation == 0 && colorSwap.brightness == 0)) {
			shdr = null;
		}
		camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shdr, colorSwap);
	}
}