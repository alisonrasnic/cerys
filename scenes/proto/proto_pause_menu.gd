extends CanvasLayer

func _on_continue_pressed():
	get_tree().paused = false;
	visible = false;

func _on_exit_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://scenes/ui/menus/MainMenu.tscn");

func _input(event):
	if (event as InputEvent).is_action("pause") and not event.is_echo() and event.is_pressed():
		get_viewport().set_input_as_handled();
		_on_continue_pressed();
