extends Node2D

func _ready():
	initialize();

func initialize():
	randomize();
	get_node("Player").connect("reset_level", reset);
	var room_0 = get_node("RoomGenerator/Rooms/Room");
	if room_0:
		for pos in room_0.get_entrance_positions():
			if pos.name == "L":
				var sprite = $Player/Sprite2D.get_rect();
				$Player.global_position = Vector2(pos.global_position.x+(sprite.size.x/2), pos.global_position.y - (sprite.size.y/2));
				$Player.process_mode = Node.PROCESS_MODE_PAUSABLE;

func _input(event):
	if not get_tree().paused:
		if event is InputEventKey and event.ctrl_pressed and event.shift_pressed:
			if event.keycode == KEY_R:
				get_tree().reload_current_scene();

		if (event is InputEventKey or event is InputEventJoypadButton) and Input.is_action_just_pressed("pause", true):
			print("????");
			get_tree().paused = true;
			$PauseMenu.visible = true;
			$PauseMenu.wait_frame = true;

func reset():
	print("Reset called")
	$Player.position = Vector2(0, 0);
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	var main = get_tree().root.get_node("main");
	
	main.fade_out();
	
	var room_0 = get_node("RoomGenerator/Rooms/Room");
	if room_0:
		for pos in room_0.get_entrance_positions():
			if pos.name == "L":
				var sprite = $Player/Sprite2D.get_rect();
				$Player.global_position = Vector2(pos.global_position.x+(sprite.size.x/2), pos.global_position.y - (sprite.size.y/2));
				$Player.process_mode = Node.PROCESS_MODE_PAUSABLE;
				main.fade_in();
	else:
		print("FAILURE");
		get_tree().quit(1);
	main.fade_in();
	print("SUCCESS");
	
func algo(main):
	if get_node("Player"):
		var sprite = $Player.get_node("Sprite2D").get_rect();
		if get_node("Room"):
			print("HELLO ?!?!!?!");
			$Player.global_position = get_node("Room/PlayerSpawn").global_position-sprite.size;
		elif get_node("Tutorial"):
			$Player.global_position = get_node("Tutorial/PlayerSpawn").global_position-sprite.size;
		elif get_node("RoomGenerator"):
			pass;
			

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true;
		$PauseMenu.visible = true;

func pause_game(time):
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	Global.pause_game(time);
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	$Player.process_mode = Node.PROCESS_MODE_DISABLED;
	
