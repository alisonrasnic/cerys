extends Node2D

class_name DungeonGenerator;

func append_path(arr, pos, width):
	# we want to create a circular path with pos being the center
	arr.append(pos);
	for i in range(0, floor(width/2)):
		arr.append(Vector2(pos.x-i, pos.y));
		arr.append(Vector2(pos.x+i, pos.y));
		
		arr.append(Vector2(pos.x, pos.y-i));
		arr.append(Vector2(pos.x, pos.y+i));
