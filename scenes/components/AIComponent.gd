class_name AIComponent extends InputComponent

var pos;
var aggro = false;

@export var aggro_distance: float = 350.0;
@export var passive_distance: float = 250.0;

func update_player_position(player_pos):
	pos = player_pos;

# override these methods

func get_move_axis(host):
	return 0;
	
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
