extends Control

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_exit_pressed():
	get_tree().quit();

func _on_start_game_pressed():
	var root = get_tree().root;
	var main = root.get_node("main");
	
	main.fade_out();
	ResourceLoader.load_threaded_request("res://scenes/game.tscn")
	
	await get_tree().create_timer(1.0).timeout;
	
	defer_call_goto.call_deferred("res://scenes/game.tscn");

func defer_call_goto(path):
	var tree = get_tree();
	var root = tree.root;
	tree.current_scene.free();
	var node = ResourceLoader.load_threaded_get(path);
	var scene = node.instantiate();
	root.add_child(scene);
	tree.current_scene = scene;

func _on_load_game_pressed():
	pass # Replace with function body.

func _on_settings_pressed():
	pass # Replace with function body.
