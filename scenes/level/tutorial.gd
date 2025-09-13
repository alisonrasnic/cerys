extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("goto_lvl1"):
		var parent = get_parent();
		var player = get_tree().get_first_node_in_group("player");
		parent.remove_child(parent.get_child(2));
		var node = load("res://scenes/gen/room_generator.tscn");
		var level = node.instantiate();
		#var entrances = level.get_room(0).get_entrance_positions();
		#var l_pos;
		#for pos in entrances:
		#	if pos.name == "L":
		#		l_pos = pos.position;
		parent.add_child(level);
		player.reset();
		#player.position = l_pos;
		print(level.name);
		queue_free();
