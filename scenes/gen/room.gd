extends Node2D

class_name Room;

# Rect in tile coords/size
var rect: Rect2i;

@export var tiles: TileMap;
@export var area: Area2D;

var width: int = 0;
var height: int = 0;

func _init():
	pass;

func _ready():
	if area:
		area.connect("area_entered", _on_area_entered);
	
	if tiles:
		rect = Rect2i(tiles.get_used_rect().position*64, tiles.get_used_rect().size*64);
		#add_noise();
	else:
		var new_tiles = TileMap.new();
		new_tiles.set_layer_enabled(0, true);
		new_tiles.tile_set = load("res://scenes/gen/rooms/room_tilemap.tres");
		var path = [];
		for x in range(0, 20):
			for y in range(0, 20):
				if (x == 0 || x == 19) or (y == 0 || y == 19):
					path.append(Vector2i(x, y));
		new_tiles.set_cells_terrain_connect(0, path, 0, 0, 0);
		get_node("Entrances/R").set_position(Vector2(20*64, 20*64));
		print(get_node("Entrances/R").get_position());
		add_child(new_tiles);
		
func set_tiles(tiles):
	add_child(tiles);
	tiles = tiles
	pass;

func _on_area_entered(area):
	pass;
	
func add_noise():
	var rect = tiles.get_used_rect();
	for x in range(0, rect.size.x):
		for y in range(0, rect.size.y):
			print("X, Y: ", x, ", ", y);
			var tile = tiles.get_cell_tile_data(0, Vector2i(x, y));
			print(tile);
			if tile:
				print("!!!");
				var rand = randi()%25;
				if rand == 0:
					var tile_select = randi()%4;
					if tile_select == 0:
						tiles.set_cell(0, Vector2i(x, y-1), 0);
					elif tile_select == 1:
						tiles.set_cell(0, Vector2i(x+1, y), 0);
					elif tile_select == 2:
						tiles.set_cell(0, Vector2i(x, y+1), 0);
					elif tile_select == 3:
						tiles.set_cell(0, Vector2i(x-1, y), 0);

func get_entrance_positions():
	return get_node("Entrances").get_children();
