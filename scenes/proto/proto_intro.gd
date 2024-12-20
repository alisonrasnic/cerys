extends Control

func _input(event):
	if event is InputEventKey:
		if (event.pressed and event.keycode == KEY_ENTER):
			get_tree().change_scene_to_file("res://main.tscn");
	elif event is InputEventJoypadButton and event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://main.tscn");
		
