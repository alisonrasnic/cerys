extends Node2D

class_name InputComponent;

func get_move_axis():
	return Input.get_axis("left", "right");

func get_attack_input():
	return Input.is_action_just_pressed("attack");

func get_block_input():
	return Input.is_action_pressed("block");

func get_parry_input():
	return Input.is_action_just_pressed("block");

func get_jump_input():
	return Input.is_action_just_pressed("jump");

func get_dash_input():
	return Input.is_action_just_pressed("dash");

func get_dir():
	return sign(get_move_axis());
