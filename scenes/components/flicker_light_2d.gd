extends PointLight2D

class_name FlickerLight2D

@export var FlickerTime: float;

var time = 0.0;
var cur_scale = Vector2(1, 1);
# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta;
	if time >= FlickerTime:
		var r = randf()*0.1;
		cur_scale = 1-r;
		time = 0.0;
	scale = scale.lerp(Vector2(cur_scale, cur_scale), 0.1-time);
