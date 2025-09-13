extends Control

var window_sizes = [Vector2i(160, 90), Vector2i(1280, 720), Vector2i(1600, 900), Vector2i(1920, 1080), Vector2i(2560, 1440)];
var cur_size = 3;

var scales = [1,2,3,4];

var config = ConfigFile.new();

@export var window_size_selector: OptionButton;
@export var scale_selector: OptionButton;
@export var fullscreen_toggler: CheckButton;

func _init():
	pass;

func set_config(section, key, value):
	config.set_value(section, key, value);
	config.save("user://settings.ini");

func _enter_tree():
	var err = config.load("user://settings.ini");
	if err != OK:
		set_config("Video", "resolution", window_sizes[cur_size]);
		return;
	
	for section in config.get_sections():
		if section == "Video":
			var res = config.get_value(section, "resolution");
			if res:
				DisplayServer.window_set_size(res);
				var idx = window_sizes.find(res);
				cur_size = idx;
			
			if config.get_value(section, "fullscreen"):
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
				Global.Fullscreen = true;
				
				if fullscreen_toggler:
					fullscreen_toggler.toggle_mode = true;
			
			var scale = config.get_value(section, "scale");
			if scale:
				_on_scale_picker_item_selected(scale);
				if scale_selector:
					scale_selector.select(scale);
		elif section == "Input":
			var jump = config.get_value(section, "jump");
			if jump:
				InputMap.set("jump", jump);
	
	if window_size_selector:
		for x in window_sizes:
			window_size_selector.add_item(str(x.x) + ", " + str(x.y));
	
	window_size_selector.select(cur_size);

func _on_g_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(3, value-50);

func _on_fullscreen_toggled(toggled_on):
	toggle_fullscreen();

func toggle_fullscreen():
	
	Global.Fullscreen = not Global.Fullscreen;
	if Global.Fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		set_config("Video", "fullscreen", true);
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		set_config("Video", "fullscreen", false);
		_on_window_size_item_selected(cur_size);

func _on_window_size_item_selected(index):
	DisplayServer.window_set_size(window_sizes[index]);
	cur_size = index;
	set_config("Video", "resolution", window_sizes[index]);

func _on_scale_picker_item_selected(index):
	get_tree().root.content_scale_factor = scales[index];
	set_config("Video", "scale", index);

func _on_jump_bind_binding_changed(input):
	if not InputMap.action_has_event("jump", input):
		InputMap.set("jump", input);
		set_config("Input", "jump", input);

func _on_exit_button_pressed():
	get_tree().quit();
