extends Node2D

class_name Dungeon;

signal finished_generation(entry_pos);

const TILE_SIZE = 16;
const ROOM_SIZE_X = 48;
const ROOM_SIZE_Y = 32;

var width_in_rooms = 6;
var height_in_rooms = 6;

var width_in_tiles = width_in_rooms*ROOM_SIZE_X;
var height_in_tiles = height_in_rooms*ROOM_SIZE_Y;

var room_except_prob: float = 25;
const DOOR_PROB: int = 50;

var room_exceptions = [];

var possible_door_locations = [];

const EDITOR_SPEED = 4;
const EDITOR_SHIFT = 3;

var door = preload("res://scenes/interactable/locked_door_interactable.tscn");

func _init():
	generate_entrance_positions();

func _ready():
	except_rooms();
	prune_rooms();
	generate_tiles();
	
	create_path();
	add_doors();
	
	emit_signal("finished_generation", Vector2i(256, 256));

func generate_entrance_positions():
	var entrance_l: Node2D = Node2D.new();
	# The left entrance to the dungeon is somewhere along the left-most area of the dungeon
	# Probably within the top half of the dungeon
	
	entrance_l.position.y = randi()%(height_in_tiles/2)*TILE_SIZE;
	
	var entrance_r: Node2D = Node2D.new();
	# The right entrance to the dungeon is somewhere along the right-most area of the dungeon
	# Within the bottom half of the dungeon
	
	entrance_r.position.x = width_in_tiles*TILE_SIZE;
	entrance_r.position.y = (height_in_tiles/2)+(randi()%(height_in_tiles/2))*TILE_SIZE;
	
	var Entrances: Node = Node.new();
	Entrances.add_child(entrance_l);
	Entrances.add_child(entrance_r);
	
	add_child(Entrances);

func except_rooms():
	for x in range(0, width_in_rooms):
		for y in range(0, height_in_rooms):
			var r = randi()%100;
			if r <= room_except_prob-1:
				room_exceptions.append(Vector2i(x, y));

func prune_rooms():
	pass;
	
func generate_tiles():
	var path = [];
	for x in range(0, width_in_tiles):
		for y in range(0, height_in_tiles):
			if ((x+1)%ROOM_SIZE_X == 0 or (y+1)%ROOM_SIZE_Y == 0) or ((x+2)%ROOM_SIZE_X == 0 or (y+2)%ROOM_SIZE_Y == 0) or (x%ROOM_SIZE_X == 0 or y%ROOM_SIZE_Y == 0) or ((x-1)%ROOM_SIZE_X == 0 or (y-1)%ROOM_SIZE_Y == 0):
				var room_x = floor(x/ROOM_SIZE_X);
				var room_y = floor(y/ROOM_SIZE_Y);
				if not room_exceptions.has(Vector2i(room_x, room_y)):
					path.append(Vector2i(x, y));
	
	$TileMap.set_cells_terrain_connect(0, path, 0, 0);

func create_path():
	var path = [];
	
	for x in range(0, width_in_rooms):
		for y in range(0, height_in_rooms):
			var room = Vector2i(x,y);
			
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-2, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-2, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-2, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-2, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X-2, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-3));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-4));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-5));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-6));
			path.append(Vector2i(x*ROOM_SIZE_X + ROOM_SIZE_X+1, y*ROOM_SIZE_Y + ROOM_SIZE_Y-7));
			
			possible_door_locations.append(room);
	
	$TileMap.set_cells_terrain_connect(0, path, 0, -1);

func add_doors():
	for d in possible_door_locations:
		if not room_exceptions.has(d):
			if randi()%100 <= DOOR_PROB:
				var door_instance = door.instantiate();
				door_instance.position = (Vector2i(d.x*ROOM_SIZE_X, d.y*ROOM_SIZE_Y))*TILE_SIZE;
				door_instance.position.x += 16;
				door_instance.position.y += (ROOM_SIZE_Y*TILE_SIZE);
				door_instance.position.y -= 80;
				$Doors.add_child(door_instance);

func _process(delta):
	var speed = 0;
	if Input.is_key_pressed(KEY_SHIFT):
		speed = EDITOR_SHIFT*EDITOR_SPEED;
	else:
		speed = EDITOR_SPEED;
	
	speed /= $Camera2D.zoom.x*10;
	
	if Input.is_action_pressed("right"):
		$Camera2D.position.x += speed;
	if Input.is_action_pressed("left"):
		$Camera2D.position.x -= speed;
	if Input.is_action_pressed("up"):
		$Camera2D.position.y -= speed;
	if Input.is_action_pressed("down"):
		$Camera2D.position.y += speed;
	
	if Input.is_action_just_pressed("mouse_scroll_up"):
		$Camera2D.zoom /= 1.1;
	
	if Input.is_action_just_pressed("mouse_scroll_down"):
		$Camera2D.zoom *= 1.1;
