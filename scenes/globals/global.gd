extends Node

class_name GameGlobal;

var GameState: Dictionary = {
	"PlayerIsAggroed": false,
	"Perks": [],
};
var Fullscreen: bool = false;

var _time = 0.0;
var freeze_cooldown = 1.5;
var game;

@export var FREEZE_TIME: float = 0.1;

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize();

func initialize():
	GameState = {
		"PlayerIsAggroed": false,
		"Perks": [],
	};
	
	_time = FREEZE_TIME;
	game = get_tree().get_first_node_in_group("game");
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game:
		if game.process_mode == Node.PROCESS_MODE_DISABLED:
			game.get_node("Player").process_mode = Node.PROCESS_MODE_DISABLED;
			_time -= delta;
			if _time <= 0.0:
				print("Game re-entered");
				_time = FREEZE_TIME;
				game.process_mode = Node.PROCESS_MODE_INHERIT;
				game.get_node("Player").process_mode = Node.PROCESS_MODE_PAUSABLE;
		else:
			freeze_cooldown -= delta;

func pause_game(_time):
	if game and freeze_cooldown <= 0.0:
		game.process_mode = Node.PROCESS_MODE_DISABLED;
		print("Disabled game node processing");
		freeze_cooldown = 15;
	else:
		print("Game not fuond!!!!");
