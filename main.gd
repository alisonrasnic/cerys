extends Node2D

func _ready():
	randomize();
	$Player.connect("reset_level", reset);

func _input(event):
	if not get_tree().paused:
		if event is InputEventKey and event.ctrl_pressed and event.shift_pressed:
			if event.keycode == KEY_R:
				get_tree().reload_current_scene();

		if event is InputEventKey and Input.is_action_just_pressed("pause", true) and not event.is_echo():
			get_tree().paused = true;
			$proto_PauseMenu.visible = true;

func reset():
	if get_node("Room"):
		print("HELLO ?!?!!?!");
		$Player.global_position = get_node("Room/PlayerSpawn").global_position-$Player.get_node("Sprite2D").get_rect().size;
	elif get_node("Tutorial"):
		$Player.global_position = get_node("Tutorial/PlayerSpawn").global_position-$Player.get_node("Sprite2D").get_rect().size;

