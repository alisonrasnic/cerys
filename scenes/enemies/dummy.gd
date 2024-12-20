extends Node2D

func parry_dash_attack_receive():
	var enemy_animplayer = get_node("AnimationPlayer");
	enemy_animplayer.play("explode_death");
	get_node("DashDeath").play();
	await get_node("DashDeath").finished;
	queue_free();

func stun():
	parry_dash_attack_receive();

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		parry_dash_attack_receive();
