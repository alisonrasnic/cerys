extends "res://scenes/components/AIComponent.gd"

class_name VampireCrabAIComponent;

var dir = 0.0;

var timer = 0.0;
var TIME = 6.5;

func _ready():
	dir = (randi_range(1,4)-2)/2;

func update_player_position(player_pos):
	pos = player_pos;

func _physics_process(delta):
	if timer+delta > TIME:
		timer = 0.0;
		dir = (randi_range(1, 4)-2)/2;
	else:
		timer += delta;

# override these methods

func get_move_axis(host):
	return dir;
	
func get_y_move_axis(host):
	return 0;

func get_attack_input(host):
	return false;

func get_block_input(host):
	return false;

func get_parry_input(host):
	return false;

func get_jump_input(host):
	return false;

func get_dash_input(host):
	return false;

func get_sprint_input(host):
	return false;

func get_dir(host):
	return 0;
