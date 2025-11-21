package states;

import entities.NPC;
import entities.Player;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import maps.MapManager;
import maps.Room;
import haxe.ds.StringMap;
import flixel.input.mouse.FlxMouse;
import flixel.math.FlxPoint;
import Std;

class PlayState extends FlxState {

    public var player:Player;
    public var mapManager:MapManager;
    public var roomText:FlxText;

    public var roomNpcConfigs:StringMap<Array<Dynamic>>;

    // dialogue ui
    public var dialogueManager:managers.DialogueManager;
    
    var clickHandled:Bool = false;

    override public function create() {

        super.create();
        
        // configure dialogue box 
        dialogueManager = new managers.DialogueManager();
        add(dialogueManager);

        mapManager = new MapManager(this);

        // creating rooms
        var roomA = new Room("roomA", "assets/images/roomA.png");
        var roomB = new Room("roomB", "assets/images/roomB.png");
        var roomC = new Room("roomC", "assets/images/roomC.png");

        // connecting rooms
        roomA.neighbors.set("right", "roomB");
        roomB.neighbors.set("left", "roomA");
        roomA.neighbors.set("bottom", "roomC");
        roomC.neighbors.set("top", "roomA");

        mapManager.addRoom(roomA);
        mapManager.addRoom(roomB);
        mapManager.addRoom(roomC);

        // create player and add to state after room loads
        player = new Player(300, 300);

        // configuring npc data for rooms
        roomNpcConfigs = new StringMap<Array<Dynamic>>();
        roomNpcConfigs.set("roomA", [
            {id: "oldman", x: 200, y:120, sprite: "assets/images/MISSING_SPRITE.png", dialogue: ["Hello, this jawn is a test"]}
        ]);

        // load initial room
        mapManager.loadRoom("roomA");
        spawnNpcsForRoom(mapManager.current.id);

        add(player);

        // text showing currently loaded room
        roomText = new FlxText(FlxG.width - 150, 10, 140, "---", 18);
        roomText.text = "Room: " + mapManager.current.id;
        roomText.alignment = RIGHT;
        add(roomText);
    }

    public function spawnNpcsForRoom(roomId:String):Void {

        var configs = roomNpcConfigs.get(roomId);
        if (configs == null) return;
        for (cfg in configs) {
            var npc = new NPC(cfg.id, cfg.x, cfg.y, cfg.sprite, cfg.dialogue);
            if (mapManager.currentGroup != null) {
                mapManager.currentGroup.add(npc);
            } else {
                add(npc);
            }
        }
    }

    override public function update(elapsed:Float) {
        
        if (dialogueManager.isOpen) {
            player.velocity.x = 0;
            player.velocity.y = 0;

            if (FlxG.mouse.justReleased) {
                var pos = FlxG.mouse.getWorldPosition(null, flixel.math.FlxPoint.weak());
                if (dialogueManager.closeButton.overlapsPoint(pos, true)) {
                    dialogueManager.clearDialogue();
                }
            }

            return;
        }

        super.update(elapsed);

        // npc interaction
        if (FlxG.mouse.justReleased) {
            var mouseWorld = FlxG.mouse.getWorldPosition(null, flixel.math.FlxPoint.weak());

            if (mapManager.currentGroup != null) {
                for (npc in mapManager.currentGroup.members) {
                    if (npc == null) continue;
                    if (!Std.is(npc, NPC)) continue;

                    var realNpc:NPC = cast npc;

                    if (realNpc.overlapsPoint(mouseWorld, true)) {
                        var line = realNpc.nextLine();

                        if (line == "") {
                            realNpc.resetDialogue();
                            dialogueManager.clearDialogue();
                        } else {
                            dialogueManager.showLine(line);
                        }

                        break;
                    }
                }
            }
        }

        if (player.x + player.width < 0) {
            mapManager.gotoNeighbor("left", player);
            roomText.text = "Room: " + mapManager.current.id;
            spawnNpcsForRoom(mapManager.current.id);
            return;
        } else if (player.x > FlxG.width) {
            mapManager.gotoNeighbor("right", player);
            roomText.text = "Room: " + mapManager.current.id;
            spawnNpcsForRoom(mapManager.current.id);
            return;
        } else if (player.y + player.height < 0) {
            mapManager.gotoNeighbor("top", player);
            roomText.text = "Room: " + mapManager.current.id;
            spawnNpcsForRoom(mapManager.current.id);
            return;
        } else if (player.y > FlxG.height) {
            mapManager.gotoNeighbor("bottom", player);
            roomText.text = "Room: " + mapManager.current.id;
            spawnNpcsForRoom(mapManager.current.id);
            return;
        }
    }
}