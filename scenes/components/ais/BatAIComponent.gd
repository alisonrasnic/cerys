extends AIComponent

func get_move_axis(host):
	if pos != null:
		if pos.x > host.position.x:
			return 1;
		elif pos.x < host.position.x:
			return -1;
		
	return 0;
