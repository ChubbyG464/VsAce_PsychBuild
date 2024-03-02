package sprites;


import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxFrame;

class FlxScaleFixedSprite extends FlxSprite {
    public var scaledOffset:Bool = false;

    override public function draw():Void
    {
        checkEmptyFrame();

        if (alpha == 0 || _frame.type == FlxFrameType.EMPTY)
            return;

        if (dirty) // rarely
            calcFrame(useFramePixels);

        for (camera in cameras)
        {
            if (!camera.visible || !camera.exists || !isOnScreen(camera))
                continue;

            getScreenPosition(_point, camera);
            if(!scaledOffset) {
                _point.subtractPoint(offset);
            }

            if (isSimpleRender(camera))
                drawSimple(camera);
            else
                drawComplex(camera);

            #if FLX_DEBUG
            FlxBasic.visibleCount++;
            #end
        }

        #if FLX_DEBUG
        if (FlxG.debugger.drawDebug)
            drawDebug();
        #end
    }

    @:noCompletion
    override function drawSimple(camera:FlxCamera):Void
    {
        if (isPixelPerfectRender(camera))
            _point.floor();

        if(scaledOffset) _point.subtractPoint(offset);

        _point.copyToFlash(_flashPoint);
        camera.copyPixels(_frame, framePixels, _flashRect, _flashPoint, colorTransform, blend, antialiasing);
    }

    @:noCompletion
    override function drawComplex(camera:FlxCamera):Void
    {
        _frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());
        _matrix.translate(-origin.x, -origin.y);
        if(scaledOffset) {
            _matrix.translate(-offset.x, -offset.y);
        }
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

        camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shader);
    }
}