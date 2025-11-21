package maps;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import entities.Player;
import haxe.ds.StringMap;

class MapManager {

    public var state:FlxState;
    public var rooms:StringMap<Room>;
    public var current:Room;
    public var currentGroup:FlxGroup;

    public function new(state:FlxState) {

        this.state = state;
        this.rooms = new StringMap<Room>();
        this.currentGroup = new FlxGroup();
    }

    public function addRoom(room:Room):Void {

        rooms.set(room.id, room);
    }

    public function loadRoom(id:String, ?entryDirection:String, ?player:Player):Void {

        var next = rooms.get(id);
        if (next == null) return;

        if (currentGroup != null) state.remove(currentGroup);

        currentGroup = new FlxGroup();
        next.create(currentGroup);
        state.add(currentGroup);
        current = next;

        if (player != null && entryDirection != null) {

            switch (entryDirection) {
                case "left":
                    player.x = FlxG.width - player.width - 1;
                case "right":
                    player.x = 1;
                case "top":
                    player.y = FlxG.height - player.height - 1;
                case "bottom":
                    player.y = 1;
                default:
            }
        }
    }

    public function gotoNeighbor(direction:String, player:Player):Void {

        if (current == null) return;
        var neighborId = current.neighbors.get(direction);
        if (neighborId == null) return;
        
        loadRoom(neighborId, direction, player);

    }

}