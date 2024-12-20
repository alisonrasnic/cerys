extends Control

var window_sizes = [Vector2i(256, 132), Vector2i(512, 263),Vector2i(1024, 576),Vector2i(1280, 720),Vector2i(1920, 1080),Vector2i(2560, 1440)];
var window_size: int = 4;

func _on_fullscreen_toggled(toggled_on):
	if !toggled_on:
		$MarginContainer/GridContainer/Fullscreen.text = "Fullscreen: On";
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		var max_size = DisplayServer.window_get_max_size(DisplayServer.window_get_current_screen());
		var indx = window_sizes.find(max_size);
		window_size = indx;
		_on_windowsize_pressed();
	else:
		$MarginContainer/GridContainer/Fullscreen.text = "Fullscreen: Off";
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		DisplayServer.window_set_size(window_sizes[window_size]);
	
func _on_windowsize_pressed():
	print(window_size, " : ", len(window_sizes));
	if !$MarginContainer/GridContainer/Fullscreen.toggled:
		window_size += 1;
		if window_size >= len(window_sizes):
			window_size = 0;
		
	$MarginContainer/GridContainer/Windowsize.text = str(window_sizes[window_size]);
	DisplayServer.window_set_size(window_sizes[window_size]);

func _on_g_volume_slider_value_changed(value):
	var new_val = log(value+1);
	print(new_val);
	AudioServer.set_bus_volume_db(3, value-50);
