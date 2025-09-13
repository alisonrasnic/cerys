extends AIComponent

func _process(delta):
	if aggro:
		pass;

func get_move_axis(host):
	if pos != null:
		var x_distance = abs(global_position.x+64 - pos.x);
		if (x_distance < passive_distance or (aggro and x_distance < aggro_distance)) and x_distance >= 64.0:
			set_aggro(true);
			if pos.x > host.global_position.x:
				host.facing = '_l';
				return 1;
			elif pos.x < host.global_position.x:
				host.facing = '';
				return -1;
		else:
			set_aggro(false);
		
	return 0;

func get_move_y_axis(host):
	return 0;
	
func get_attack_input(host):
	var x_distance = abs(global_position.x+64 - pos.x);
	return (x_distance < passive_distance or (aggro and x_distance < aggro_distance)) and x_distance >= 64.0;
