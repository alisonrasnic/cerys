extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("goto_lvl1"):
		var parent = get_parent();
		var player = get_tree().get_first_node_in_group("player");
		parent.remove_child(parent.get_child(2));
		var node = load("res://scenes/gen/rooms/Level1.tscn");
		var level = node.instantiate();
		parent.add_child(level);
		player.reset();
		print(level.name);
		queue_free();
