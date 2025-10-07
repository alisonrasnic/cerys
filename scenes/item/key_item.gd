extends RigidBody2D

func _on_area_2d_body_entered(body):
	if body is Player:
		var player = body as Player;
		player.player_state.add_key();
		print("!");
		queue_free();
