package sprites;


import flixel.FlxSprite;

using StringTools;

class AnimationSprite extends FlxSprite
{
    public var animOffsets = new Map<String, Array<Float>>();

    override function destroy() {
        super.destroy();

        if(animOffsets != null) {
            animOffsets.clear();
            animOffsets = null;
        }
    }

    public inline function addAnimationByPrefix(name:String, xmlName:String, offset:Array<Float>, fps:Int=30, looped:Bool=true, flipX:Bool=false, flipY:Bool=false) {
        animation.addByPrefix(name, xmlName, fps, looped, flipX, flipY);
        animOffsets[name] = offset;
    }
    public inline function addAnimationByIndices(name:String, xmlName:String, offset:Array<Float>, frames:Array<Int>, fps:Int=30, looped:Bool=true, flipX:Bool=false, flipY:Bool=false) {
        animation.addByIndices(name, xmlName, frames, "", fps, looped, flipX, flipY);
        animOffsets[name] = offset;
    }

    public function playAnim(animName:String, force:Bool = false, reversed:Bool = false, frame:Int = 0):Void
    {
        animation.play(animName, force, reversed, frame);

        if (animOffsets.exists(animName)) {
            var daOffset = animOffsets.get(animName);
            offset.set(daOffset[0], daOffset[1]);
        }
        else
            offset.set(0, 0);
    }

    public function safePlayAnim(animName:String, force:Bool = false, reversed:Bool = false, frame:Int = 0):Void
    {
        if(animation.getByName(animName) == null) return;

        playAnim(animName, force, reversed, frame);
    }

    public inline function addOffset(name:String, x:Float = 0, y:Float = 0)
    {
        animOffsets[name] = [x, y];
    }
}