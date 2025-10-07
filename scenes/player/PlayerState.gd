extends Node

class_name PlayerState;

var keys: int = 0;

# var perks: Array = [];
# var memories: Array = [];

var infection: float = 0.0;

func add_key():
	keys += 1;
