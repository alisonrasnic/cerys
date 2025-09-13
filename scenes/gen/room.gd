extends Node2D

class_name Room;

# Rect in tile coords/size
var rect: Rect2i;

@export var tiles: TileMap;
@export var area: Area2D;

func _ready():
	if area:
		area.connect("area_entered", _on_area_entered);
	
	if tiles:
		rect = Rect2i(tiles.get_used_rect().position*64, tiles.get_used_rect().size*64);
		#add_noise();
		
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
