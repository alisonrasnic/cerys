extends CanvasLayer

func _on_continue_pressed():
	get_tree().paused = false;
	visible = false;

func _on_exit_pressed():
	get_tree().quit();

func _input(event):
	if (event as InputEvent).is_action("pause") and not event.is_echo() and event.is_pressed():
		get_viewport().set_input_as_handled();
		_on_continue_pressed();
