package entities;

import flixel.FlxSprite;
import flixel.FlxG;

class NPC extends FlxSprite {

    public var id:String;
    public var spritePath:String;
    public var dialogue:Array<String>;
    public var lineIndex:Int = 0;

    public function new(id:String, x:Int, y:Int, ?spritePath:String, ?dialogue:Array<String>) {

        super(x, y);
        this.id = id;
        this.spritePath = spritePath;
        this.dialogue = dialogue != null ? dialogue : [];
        if (spritePath != null) loadGraphic(spritePath);
        immovable = true;
    }

    public function setDialogue(lines:Array<String>):Void {

        dialogue = lines;
        lineIndex = 0;
    }

    public function nextLine():String {

        if (dialogue.length == 0) return "";
        var s = dialogue[lineIndex];
        if (lineIndex < dialogue.length - 1) lineIndex++;
        return s;
    }

    public function resetDialogue():Void {
        lineIndex = 0;
    }

    public function allLines():Array<String> {
        return dialogue;
    }
}