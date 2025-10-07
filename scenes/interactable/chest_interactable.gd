extends Interactable;

@export var lockpicking: CanvasLayer;

var player: Player;

func _ready():
	pass # Replace with function body.

func _process(delta):
	if player and player.input_component.get_interact(player):
		_interact(player);

func _interact(host):
	if host.player_state.keys > 0:
		host.player_state.keys -= 1;
		queue_free();

func _on_area_2d_body_entered(body):
	$Label.visible = true;
	if body is Player:
		player = body as Player;

func _on_area_2d_body_exited(body):
	$Label.visible = false;
	if body is Player:
		player = null;
		lockpicking.visible = false;
	
