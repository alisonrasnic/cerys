extends DungeonGenerator;

class_name Camp;

const WIDTH_IN_TILES: int = 100*32;

func _ready():
	generate_entrance();
	generate_floor();
	generate_tents();
	
	add_enemies();

func _process(delta):
	pass

func generate_floor():
	var path = [];
	for x in range(0, WIDTH_IN_TILES):
		append_path(path, Vector2(x, 0), 10);
	$TileMap.set_cells_terrain_connect(0, path, 0, 0);

func generate_entrance():
	var path = [];
	var poles = (randi()%4)+3;
	var base_y = -5;
	
	for i in range(0, poles):
		var x_pos = randi()%90 + 10;
		var height = randi()%6+6;
		
		for y in range(0, height):
			append_path(path, Vector2(x_pos, base_y-y), 10);
	
	$TileMap.set_cells_terrain_connect(0, path, 0, 1);
	
func generate_tents():
	pass;

func add_enemies():
	pass;
