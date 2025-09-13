extends CanvasLayer

var wait_frame = false;

func _process(delta):
	if not wait_frame and Input.is_action_just_pressed("pause"):
		get_tree().paused = false;
		self.visible = false;
	wait_frame = false;
