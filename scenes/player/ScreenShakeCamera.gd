extends Camera2D

class_name ScreenShakeCamera;

var amount = 0;
var orig_offset;

func shake(amt):
	amount = amt;
	if amount >= 2:
		amount = 0.9999*2;

func _ready():
	amount = 0;
	orig_offset = offset;

func _physics_process(delta):
	offset.x = amount*randf_range(-1, 1);
	offset.y = amount*randf_range(-1, 1);
	offset = offset+orig_offset;
	amount = pow(0.5, amount) - 1;
	if amount > 2:
		amount = 0.9999*2;
