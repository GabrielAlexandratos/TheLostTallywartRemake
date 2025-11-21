package managers;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.group.FlxGroup;

class DialogueManager extends FlxGroup {
    public var dialogueText:FlxText;

    public function new() {
        super();

        var boxWidth = FlxG.width - 40;
        var boxHeight = 60;

        var dialogueBox = new flixel.FlxSprite();
        dialogueBox.makeGraphic(boxWidth, boxHeight, 0xFF555555);

        // center horizontally near bottom
        dialogueBox.x = (FlxG.width - boxWidth) / 2;
        dialogueBox.y = FlxG.height - boxHeight - 20;

        add(dialogueBox);

        dialogueText = new FlxText(0, 0, boxWidth, "");
        dialogueText.size = 16;
        dialogueText.alignment = "center";

        dialogueText.x = dialogueBox.x;
        dialogueText.y = dialogueBox.y + (boxHeight / 2) - (dialogueText.size / 2);

        add(dialogueText);
    }

    public function showLine(line:String):Void {
        dialogueText.text = line;
    }

    public function clearDialogue():Void {
        dialogueText.text = "";
    }
}
