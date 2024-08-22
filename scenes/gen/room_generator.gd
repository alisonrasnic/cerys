extends Node2D

class_name RoomGenerator;

@export var rooms = 10;

@export var Rooms: Node;

@onready var RoomTypes = [preload("res://scenes/gen/rooms/LRRoom.tscn"), preload("res://scenes/gen/rooms/VertLRRoom.tscn"), preload("res://scenes/gen/rooms/LRPitfall.tscn")];

func _ready():
	var rooms_arr = [];
	var curr_position = Vector2.ZERO;
	for x in range(0, rooms):
		var which_room = randi()%len(RoomTypes);
		var room_instant;
		room_instant = RoomTypes[which_room].instantiate();
		
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
			
			curr_position.x += right_pos1.position.x;
			curr_position.y += right_pos1.position.y;
			curr_position   -= left_pos2.position;
			room_instant.position = curr_position;
			
			# so, the idea is going to be having opposite entrances line up with their offsets
			# i.e. we're going to have the R exit of the previous line up with the L exit of the next room
		
		rooms_arr.append(room_instant);
	
	for room in rooms_arr:
		Rooms.add_child(room);
