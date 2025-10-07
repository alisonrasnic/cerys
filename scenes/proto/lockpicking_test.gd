
extends CanvasLayer

@export var sound: RoundRobinSound2D;

@export var first: CheckBox;

signal unlock;

# value between 0 - 1023
var combination: int = 0b0100_0000_0;

var random_clicks = [];
@export var random_click_prob: float = 10;
@export var prob_reduce: float = 50;

func _ready():
	first.grab_focus();
	combination = randi() % 512;
	
	return;
	var roll = randi()%100;
	var idx = randi()%9;
	var attempts = 0;
	#TODO: With 200% prob and reduction of 50%, it should always generate 2 fake clicks but it doesn't always generate even one?
	while roll <= random_click_prob and len(random_clicks) < 10 and attempts <= 100:
		while combination_has_bit(idx) and attempts <= 100:
			if attempts > 100:
				return;
			idx = randi()%9;
		if attempts > 100:
			random_clicks.append(randi()%9);
			random_click_prob /= prob_reduce;
			return;
		else:
			random_clicks.append(randi()%9);
			random_click_prob /= prob_reduce;
		
		attempts += 100000;

func checkboxes_as_9bit():
	var combo = 0;
	var idx = 0;
	for child in $VBoxContainer/GridContainer.get_children():
		var check = child as CheckBox;
		if check.button_pressed:
			combo += pow(2, idx);
		idx += 1;
	return combo;

func _process(delta):
	if checkboxes_as_9bit() == combination:
		$VBoxContainer/Label.text = "Unlocked!";
		unlock.emit();
		
	else:
		$VBoxContainer/Label.text = "Locked!";
	
	if OS.has_feature('debug') and Input.is_action_just_pressed("dev_reset"):
		get_tree().reload_current_scene();

func _on_check_box_toggled(toggled_on, extra_arg_0):
	var bit = 1;
	bit = bit << extra_arg_0;
	
	# check if bit matches our combination
	if toggled_on and (combination_has_bit(bit) or random_clicks.has(extra_arg_0)):
		sound.play_rand();

func combination_has_bit(bit):
	var idx = (log(bit)/log(2)) as int;
	
	# 0b0_0000_1000
	# idx = 2
	# 0b0_0000_0010
	var i = combination >> idx;
	
	var ret = i & 1;
	
	return ret == 1;
