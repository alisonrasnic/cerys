extends Node2D

class_name RoomGenerator;

const MAX_DESC_DIST: float = 1024.0;

@export var rooms = 3;

@export var Rooms: Node;

@onready var EnemyRooms = [preload("res://scenes/gen/rooms/LRRoom2.tscn")];
@onready var PlatformingRooms = [preload("res://scenes/gen/rooms/LRDashRoom.tscn"), preload("res://scenes/gen/rooms/VertLRRoom.tscn"), preload("res://scenes/gen/rooms/LRPitfall.tscn"), preload("res://scenes/gen/rooms/LDownSplit1.tscn")];

@onready var TutRoom = preload("res://scenes/gen/rooms/TutorialRoom.tscn")

@onready var Room = preload("res://scenes/gen/room.tscn");

var enemyParity = false;

func rod(x):
	var inner_arg = exp((x-20)/5) + 1
	var y = -log(abs(inner_arg)) - log(x+1)
	return y

# rod is Rate of Descent
func dist_sq_to_rod(pos: Vector2):
	var rod_pos = Vector2(pos.x, rod(pos.x))
	return rod_pos.distance_squared_to(pos)

func get_room(idx):
	return Rooms.get_child(idx);

func _ready():
	var rooms_arr = [];
	
	for n in Rooms.get_children():
		Rooms.remove_child(n);
		n.queue_free();
	
	var curr_position = Vector2.ZERO;
	var tut_room = TutRoom.instantiate();
	rooms_arr.append(tut_room);
	for x in range(1, rooms):
		var room_instant;
		if true: #dist_sq_to_rod(curr_position) < MAX_DESC_DIST or dist_sq_to_rod(curr_position) >= MAX_DESC_DIST:
			var which_room;
			#if enemyParity:
				#which_room = randi()%len(EnemyRooms);
				#room_instant = EnemyRooms[which_room].instantiate();
			#else:
				#which_room = randi()%len(PlatformingRooms);
				#room_instant = PlatformingRooms[which_room].instantiate();
			#enemyParity = not enemyParity;
			
			room_instant = Room.instantiate();
			
			if x != 0:
				var previous_room = rooms_arr[x-1];
				var positions = previous_room.get_entrance_positions();
				
				var right_pos1;
				var left_pos1;
				for pos in positions:
					if pos.name == "R":
						right_pos1 = pos;
					elif pos.name == "L":
						left_pos1 = pos;
				
				var right_pos2;
				var left_pos2;
				for pos in room_instant.get_entrance_positions():
					print(pos);
					if pos.name == "R":
						right_pos2 = pos;
					elif pos.name == "L":
						left_pos2 = pos;
				
				if right_pos1 == null or left_pos1 == null or right_pos2 == null or left_pos2 == null:
					push_error("FUCK");
				# idea: this has the offset of each room too, so depending on the previous room it fucks up the next room ??
				curr_position = previous_room.position;
				#curr_position += right_pos.position;
				#room_instant.position = curr_position;
				
				print("Previous room right entrance: ", right_pos1.position);
				curr_position.x += right_pos1.position.x;
				curr_position.y += right_pos1.position.y;
				curr_position   -= left_pos2.position;
				
				# so, the idea is going to be having opposite entrances line up with their offsets
				# i.e. we're going to have the R exit of the previous line up with the L exit of the next room
		else:
			room_instant = Room.new();
			
		room_instant.position = curr_position;
		
		rooms_arr.append(room_instant);
	
	for room in rooms_arr:
		Rooms.add_child(room);
		print("?");
