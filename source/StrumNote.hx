package;

import flixel.math.FlxRect;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.FlxCamera;
import ColorSwap.CSData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;


using StringTools;

class StrumNote extends FlxShakableSprite
{
	public var colorSwap:CSData;
	public static var staticColorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;


	public var isConfirm = false;

	public var frozen = false;

	private var player:Int;

	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function new(x:Float, y:Float, leData:Int, player:Int) {
		colorSwap = new CSData();
		if(staticColorSwap == null) {
			staticColorSwap = new ColorSwap();
		}
		shader = staticColorSwap.shader;
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var skin:String = 'NOTE_assets';
		if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		texture = skin; //Load texture and anims

		scrollFactor.set();
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		if(PlayState.isPixelStage)
		{
			loadGraphic(Paths.image('pixelUI/' + texture));
			width = width / 4;
			height = height / 5;
			loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

			antialiasing = false;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));

			animation.add('green', [6]);
			animation.add('red', [7]);
			animation.add('blue', [5]);
			animation.add('purple', [4]);
			switch (Math.abs(noteData))
			{
				case 0:
					animation.add('static', [0]);
					animation.add('pressed', [4, 8], 12, false);
					animation.add('confirm', [12, 16], 24, false);
				case 1:
					animation.add('static', [1]);
					animation.add('pressed', [5, 9], 12, false);
					animation.add('confirm', [13, 17], 24, false);
				case 2:
					animation.add('static', [2]);
					animation.add('pressed', [6, 10], 12, false);
					animation.add('confirm', [14, 18], 24, false);
				case 3:
					animation.add('static', [3]);
					animation.add('pressed', [7, 11], 12, false);
					animation.add('confirm', [15, 19], 24, false);
			}
		}
		else
		{
			var dataDir = ["left", "down", "up", "right"];
			frames = Paths.getSparrowAtlas(texture);

			var alreadyHasFrozen = false;
			for(frame in frames.frames) {
				if(frame.name.startsWith("arrowFrozen")) {
					alreadyHasFrozen = true;
					break;
				}
			}

			if(!alreadyHasFrozen && PlayState.instance != null && PlayState.instance.hasIceNotes) {
				trace("Added Frozen to strums since missing");
				addFrames(Paths.getSparrowAtlas("FrozenStrums"));
			}

			antialiasing = ClientPrefs.globalAntialiasing;
			setGraphicSize(Std.int(width * 0.7));

			var dir = dataDir[noteData].toLowerCase();
			animation.addByPrefix('static', 'arrow' + dir.toUpperCase());
			animation.addByPrefix('pressed', dir + ' press', 24, false);
			animation.addByPrefix('confirm', dir + ' confirm', 24, false);
			if(alreadyHasFrozen || PlayState.instance != null && PlayState.instance.hasIceNotes) {
				animation.addByPrefix('frozen', 'arrowFrozen' + dir.toUpperCase(), 24, true);
				//trace("Added Frozen");
			}
		}
		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		//if(animation.curAnim != null){ //my bad i was upset
		if(isConfirm && !PlayState.isPixelStage) {
			centerOrigin();
		//}
		}

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false, ?note:Note = null) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		if(animation.curAnim == null || animation.curAnim.name == 'static') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		} else {
			colorSwap.hue = ClientPrefs.arrowHSV[noteData % 4][0] / 360;
			colorSwap.saturation = ClientPrefs.arrowHSV[noteData % 4][1] / 100;
			colorSwap.brightness = ClientPrefs.arrowHSV[noteData % 4][2] / 100;

			if(isConfirm && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}
	}

	public function addFrames(otherFrames:FlxAtlasFrames, reload:Bool = true) {
		if(otherFrames == null) return;
		for(frame in otherFrames.frames) {
			this.frames.pushFrame(frame);
		}
		if(reload) {
			this.frames = this.frames;
		}
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

		if(shakeDistance != 0) {
			_matrix.translate(FlxG.random.float(-shakeDistance, shakeDistance), FlxG.random.float(-shakeDistance, shakeDistance));
		}

		if (isPixelPerfectRender(camera))
		{
			_matrix.tx = Math.floor(_matrix.tx);
			_matrix.ty = Math.floor(_matrix.ty);
		}

		camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shader, colorSwap);
	}
}
