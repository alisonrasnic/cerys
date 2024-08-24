extends Control

class_name EntityUIComponent;

@export var progress_bar: ProgressBar;

func change_health(val):
	progress_bar.value = val;
	
func add_health(val):
	change_health(progress_bar.value+val);

func change_max_health(val, change_current := false):
	progress_bar.max_value = val;
	if change_current:
		progress_bar.value = val;
