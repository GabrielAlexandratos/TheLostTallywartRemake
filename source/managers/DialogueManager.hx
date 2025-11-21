package managers;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;


class DialogueManager extends FlxGroup {
    public var dialogueBox:FlxSprite;
    public var closeButton:FlxSprite;
    public var isOpen:Bool = false;
    public var dialogueText:FlxText;

    public function new() {
        super();

        var boxWidth = FlxG.width - 40;
        var boxHeight = 60;

        dialogueBox = new flixel.FlxSprite();
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
        
        closeButton = new FlxSprite();
        closeButton.loadGraphic("assets/images/MISSING_SPRITE.png");
        closeButton.x = dialogueBox.x + dialogueBox.width - 20;
        closeButton.y = dialogueBox.y + 4;
        add(closeButton);

        dialogueBox.visible = false;
        dialogueText.visible = false;
        closeButton.visible = false;
    }

    public function showLine(line:String):Void {
        dialogueText.text = line;
        isOpen = true;
        dialogueBox.visible = true;
        dialogueText.visible = true;
        closeButton.visible = true;
    }

    public function clearDialogue():Void {
        dialogueText.text = "";
        isOpen = false;
        dialogueBox.visible = false;
        dialogueText.visible = false;
        closeButton.visible = false;
    }
}
