package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite {
    
    final speed:Int = 100; 
     
	public function new(xPos:Int = 0, yPos:Int = 0) {


		super(xPos, yPos);
        loadGraphic("assets/images/MISSING_SPRITE.png");
	}

    function movement() {

        final left = FlxG.keys.anyPressed([LEFT, A]);
        final right = FlxG.keys.anyPressed([RIGHT, D]);
        final up = FlxG.keys.anyPressed([UP, W]);
        final down = FlxG.keys.anyPressed([DOWN, S]);

        if (right) {
            velocity.x = speed;
        } else if (left) {
            velocity.x = -speed;
        } else {
            velocity.x = 0;
        }

        if (up) {
            velocity.y = -speed;
        } else if (down) {
            velocity.y = speed;
        } else {
            velocity.y = 0;
        }
    }

    override function update(elapsed:Float) {
        
        super.update(elapsed);
        movement();
    }
}