package maps;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import haxe.ds.StringMap;

class Room {

    public var id:String;
    public var background:String;
    public var neighbors:StringMap<String>;

    public function new(id:String, ?background:String) {
        
        this.id = id;
        this.background = background;
        this.neighbors = new StringMap<String>();
    }

    public function create(group:FlxGroup):Void {

        if (background != null) {

            var bg = new FlxSprite(0, 0);
            bg.loadGraphic(background);
            group.add(bg);
        }
    }
}