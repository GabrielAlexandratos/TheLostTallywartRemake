package states;

import entities.Player;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import maps.MapManager;
import maps.Room;
import flixel.FlxObject;

class PlayState extends FlxState {

    public var player:Player;
    public var mapManager:MapManager;
    public var roomText:FlxText;

    override public function create() {

        super.create();

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

        // load initial room
        mapManager.loadRoom("roomA");
        add(player);

        // text showing currently loaded room
        roomText = new FlxText(FlxG.width - 150, 10, 140, "---", 18);
        roomText.text = "Room: " + mapManager.current.id;
        roomText.alignment = RIGHT;
        add(roomText);
    }

    override public function update(elapsed:Float) {
        
        super.update(elapsed);

        if (player.x + player.width < 0) {
            mapManager.gotoNeighbor("left", player);
            roomText.text = "Room: " + mapManager.current.id;
            return;
        } else if (player.x > FlxG.width) {
            mapManager.gotoNeighbor("right", player);
            roomText.text = "Room: " + mapManager.current.id;
            return;
        } else if (player.y + player.height < 0) {
            mapManager.gotoNeighbor("top", player);
            roomText.text = "Room: " + mapManager.current.id;
            return;
        } else if (player.y > FlxG.height) {
            mapManager.gotoNeighbor("bottom", player);
            roomText.text = "Room: " + mapManager.current.id;
            return;
        }
    }
}