extends Area2D

class_name AggroComponent;

signal player_enter;
signal player_leave;

func _on_body_entered(body):
	if get_tree().get_nodes_in_group("player").has(body):
		emit_signal("player_enter");

func _on_body_exited(body):
	if get_tree().get_nodes_in_group("player").has(body):
		emit_signal("player_leave");
