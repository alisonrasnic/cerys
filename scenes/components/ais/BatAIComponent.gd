extends AIComponent

func get_move_axis(host):
	if pos != null:
		var new_pos = pos - Vector2(32, 32);
		if (host.global_position.distance_to(new_pos) < passive_distance or (aggro and host.global_position.distance_to(new_pos) < aggro_distance)) and host.global_position.distance_to(new_pos) >= 100.0:
			set_aggro(true);
			print("Please!!!");
			if new_pos.x > host.global_position.x:
				host.facing = '';
				return 1;
			elif new_pos.x < host.global_position.x:
				host.facing = '_l';
				return -1;
		
	return 0;

func get_move_y_axis(host):
	if pos != null:
		var new_pos = pos - Vector2(32, 32);
		if (host.global_position.distance_to(new_pos) < passive_distance or (aggro and host.global_position.distance_to(new_pos) < aggro_distance)) and host.global_position.distance_to(new_pos) >= 100.0:
			set_aggro(true);
			if new_pos.y > host.global_position.y:
				return 1;
			elif new_pos.y < host.global_position.y:
				return -1;
		
	return 0;

func get_attack_input(host):
	var new_pos = pos - Vector2(32, 32);
	if host.global_position.distance_to(new_pos) < aggro_distance:
		return true;
	else:
		return false;
