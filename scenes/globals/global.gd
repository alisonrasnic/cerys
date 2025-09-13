extends Node

var GameState: Dictionary = {"PlayerIsAggroed": false};
var Fullscreen: bool = false;

var time = 0.0;
var game;

@export var FREEZE_TIME: float = 0.0167;

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize();

func initialize():
	GameState = {"PlayerIsAggroed": false};
	time = FREEZE_TIME;
	game = get_tree().get_first_node_in_group("game");
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game:
		if game.process_mode == Node.PROCESS_MODE_DISABLED:
			game.get_node("Player").process_mode = Node.PROCESS_MODE_DISABLED;
			time -= delta;
			if time <= 0.0:
				print("Game re-entered");
				time = FREEZE_TIME;
				game.process_mode = Node.PROCESS_MODE_INHERIT;
				game.get_node("Player").process_mode = Node.PROCESS_MODE_PAUSABLE;

func pause_game(time):
	if game:
		game.process_mode = Node.PROCESS_MODE_DISABLED;
		print("Disabled game node processing");
	else:
		print("Game not fuond!!!!");
