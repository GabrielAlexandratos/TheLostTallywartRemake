package states;

import entities.Player;
import flixel.FlxState;

class PlayState extends FlxState {

	override public function create() {

		super.create();

		final player = new Player();
		add(player);
	}

	override public function update(elapsed:Float) {
		
		super.update(elapsed);
	}
}