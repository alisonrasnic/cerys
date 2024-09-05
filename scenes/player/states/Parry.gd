extends Node

@export var parry_frame = false;

func enter(host):
	if host.facing == 'r':
		host.animation.play("parry");
	else:
		host.animation.play("parry_l");

func initialize(host):
	pass;

func exit(host):
	pass;

func update(host, delta):
	var return_state = null;
	var input = host.input_component;
	
	if input and input.get_block_input(host):
		if host.animation.current_animation == "parry" and not host.animation.is_playing():
			return_state = 'block';
			host.animation.play("block");
	if input and not input.get_block_input(host):
		if not host.animation.is_playing():
			host.animation.play("RESET");
			return_state = 'idle';
	
	host.move_and_slide();
	
	return return_state;

func process(host, delta):
	pass;

func _on_hurtbox_component_area_entered(host, area):
	if area is HurtboxComponent and area != host.hurtbox_component and parry_frame:
		print("WE PARRIED");
		var enemy = area.get_parent();
		var stun = enemy.parry_receive();
		host.screen_shake(2.0);
		enemy.get_node("Sprite2D").material.set_shader_parameter("disabled", false);
		host.get_node("ParryParticles").emitting = true;
		if stun != null:
			host._change_state('parry_dash', [stun]);
		await get_tree().create_timer(0.1).timeout;
		host.get_node("ParryParticles").emitting = false;
		enemy.get_node("Sprite2D").material.set_shader_parameter("disabled", true);
		
