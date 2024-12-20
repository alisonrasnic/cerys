extends "res://scenes/components/interactable.gd"

@export var note: int = 0;

var player = null;

func _ready():
	$CanvasLayer/Note.number = note;
	$CanvasLayer/Note.load_text();

func _process(delta):
	if player != null:
		if player.input_component.get_interact(player):
			_interact(player);

func _interact(host):
	$CanvasLayer.visible = not $CanvasLayer.visible;

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body as Player;
		$InteractableDialog.visible = true;

func _on_area_2d_body_exited(body):
	if body is Player:
		player = null;
		$InteractableDialog.visible = false;
		$CanvasLayer.visible = false;
