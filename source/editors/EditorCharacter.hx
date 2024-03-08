package editors;

import sprites.Character;

class EditorCharacter extends Character {
    public function new(x:Float, y:Float, ?character:String = 'bf', ?isPlayer:Bool = false) {
        super(x, y, character, isPlayer);
    }

    override function addHoldAnims() {}
}