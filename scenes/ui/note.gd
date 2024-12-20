extends Control

@export var person: String = "KAYO";
@export var number: int    = 1;

func load_text():
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Description.text = tr(person + "_NT" + str(number) + ".0");
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Text.text = tr(person + "_NT" + str(number) + ".1");
	
func _ready():
	load_text();
