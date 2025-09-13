extends Button

signal binding_changed(input);

var taking_input = false;

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
	
func _input(event):
	if taking_input:
		if event is InputEventKey:
			text = event.as_text();
			taking_input = false;
			self.button_pressed = false;
			emit_signal("binding_changed", event);

func _on_pressed():
	if not taking_input:
		taking_input = true;


func _on_focus_exited():
	taking_input = false;
	self.button_pressed = false;
