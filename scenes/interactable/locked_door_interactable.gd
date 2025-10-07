extends "res://scenes/components/interactable.gd"

@export var lockpicking: CanvasLayer;

var player;

func _ready():
	if lockpicking:
		lockpicking.unlock.connect(queue_free);

func _process(delta):
	if player != null:
		if player.input_component.get_interact(player):
			_interact(player);

func _interact(host):
	if host.player_state.keys > 0:
		host.player_state.keys -= 1;
		queue_free();
	else:
		if lockpicking:
			lockpicking.visible = true;

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body as Player;
		$InteractableDialog.visible = true;

func _on_area_2d_body_exited(body):
	if body is Player:
		$InteractableDialog.visible = false;
		player = null;
