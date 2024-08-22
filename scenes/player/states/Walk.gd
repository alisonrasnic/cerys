extends Node

@export var SPEED_LIM: float = 400.0*64;

func enter(host):
	pass;

func exit(host):
	pass;

func update(host, delta):
	
	if sign(host.velocity.x) != sign(host.input_component.get_move_axis()):
		host.velocity.x *= -1;
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis()) > 0.01:
		host.velocity.x += host.input_component.get_move_axis()*(sqrt(host.stats_component.Speed)/host.stats_component.Friction);
	elif host.input_component:
		return_state = 'idle';
		host.velocity.x = 0.0;
	
	if abs(host.velocity.x) > SPEED_LIM:
			var signs = sign(host.velocity.x);
			host.velocity.x = SPEED_LIM*signs;
		
	if host.input_component and host.input_component.get_jump_input() and host.is_on_floor():
		return_state = 'jump';
	
	if host.input_component and host.input_component.get_dash_input():
		return_state = 'dash';
		host.screen_shake(1);
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0:
		host.velocity.y *= 1.05;
	
	check_raycast_step(host, delta);
	
	host.move_and_slide();
	
	return return_state;

func process(host, delta):
	if host.input_component and abs(host.input_component.get_move_axis()) > 0.01:
		if host.input_component.get_move_axis() < 0:
			host.facing = 'l';
			host.animation.play("walk_l");
		else:
			host.facing = 'r';
			host.animation.play("walk");
	#if host.input_component and host.input_component.get_dash_input():
		#host.animation.play("slash");

func check_raycast_step(host, delta):
	if not host.is_on_floor():
		return;
	
	if host.get_node("R").is_colliding():
		host.position.x += 1;
		host.position.y -= 16;
	elif host.get_node("L").is_colliding():
		host.position.x -= 1;
		host.position.y -= 16;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
