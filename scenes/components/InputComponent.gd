extends Node2D

class_name InputComponent;

func get_move_axis(host):
	return Input.get_axis("left", "right");

func get_attack_input(host):
	return Input.is_action_just_pressed("attack");

func get_block_input(host):
	return Input.is_action_pressed("block");

func get_parry_input(host):
	return Input.is_action_just_pressed("block");

func get_jump_input(host):
	return Input.is_action_just_pressed("jump");

func get_jump_held(host):
	return Input.is_action_pressed("jump");

func get_dash_input(host):
	return Input.is_action_just_pressed("dash");

func get_sprint_input(host):
	return Input.is_action_pressed("dash");

func get_dir(host):
	return sign(get_move_axis(host));

func get_interact(host):
	return Input.is_action_just_pressed("interact");
