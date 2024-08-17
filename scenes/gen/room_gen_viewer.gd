extends Node2D

var zoom = 0.07;

const SPEED = 3.0;

func _ready():
	randomize();
	for idx in range(0, len($RoomGenerator.Rooms.get_children())):
		var room_node = $RoomGenerator.Rooms.get_children()[idx]
		var label = Label.new();
		label.position = room_node.position+Vector2(64, 64);
		label.text = str(idx);
		label.set("theme_override_font_sizes/font_size", 256);
		label.set("theme_override_colors/font_color", Color.RED);
		$RoomLabels.add_child(label);

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		$Camera2D.offset.x -= SPEED*(1/zoom);
	elif Input.is_action_pressed("right"):
		$Camera2D.offset.x += SPEED*(1/zoom);
	
	if Input.is_action_pressed("up"):
		$Camera2D.offset.y -= SPEED*(1/zoom);
	elif Input.is_action_pressed("down"):
		$Camera2D.offset.y += SPEED*(1/zoom);
	
	if Input.is_action_just_released("mouse_scroll_up"):
		zoom *= 1.1;
	elif Input.is_action_just_released("mouse_scroll_down"):
		zoom /= 1.1;
		
	$Camera2D.zoom.x = zoom;
	$Camera2D.zoom.y = zoom;
