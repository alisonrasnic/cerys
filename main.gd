extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_tree():
	pass;
	
func fade_out():
	$AnimationPlayer.play("fade_out");

func fade_in():
	$AnimationPlayer.play("fade_in");
