class_name AIComponent extends InputComponent

var pos = Vector2.ZERO;
var aggro = false;
var aggro_decay: float = 0.0;
const AggroLength: float = 5.0;

signal aggro_expire;

@export var aggro_distance: float = 350.0;
@export var passive_distance: float = 250.0;

func update_player_position(player_pos):
	pos = player_pos;
	
func set_aggro(val):
	if val == true:
		aggro = val;
		Global.GameState["PlayerIsAggroed"] = val;

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

func _process(delta):
	if aggro:
		aggro_decay += delta;
		if aggro_decay >= AggroLength:
			aggro_expire.emit();
			aggro = false;
			Global.GameState["PlayerIsAggroed"] = false;
