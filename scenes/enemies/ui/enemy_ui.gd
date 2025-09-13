extends Control

class_name EntityUIComponent;

@export var progress_bar: ProgressBar;
@export var progress_bar_stam: ProgressBar;

func change_health(val):
	progress_bar.value = val;
	
func add_health(val):
	change_health(progress_bar.value+val);

func change_max_health(val, change_current := false):
	progress_bar.max_value = val;
	if change_current:
		progress_bar.value = val;

func change_stam(val):
	progress_bar_stam.value = val;

func add_stam(val):
	change_stam(progress_bar_stam.value+val);

func change_max_stam(val, change_current := false):
	if progress_bar_stam:
		progress_bar_stam.max_value = val;
		if change_current:
			progress_bar_stam.value = val;
