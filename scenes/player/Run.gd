extends Node

@export var SPEED_LIM: float = 600;

func enter(host):
	var stone_footstep = host.get_node("sfx/footstep_stone");
	stone_footstep.pitch_scale = 1.25;
	stone_footstep.play();

func exit(host):
	var stone_footstep = host.get_node("sfx/footstep_stone");
	stone_footstep.stop();

func update(host, delta):
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis(host)) > 0.01 and host.input_component.get_sprint_input(host):
		host.velocity.x += 1.8*host.input_component.get_move_axis(host)*host.stats_component.Speed;
	elif host.input_component and not host.input_component.get_sprint_input(host):
		return_state = 'idle';
	
	if host.stats_component:
		host.velocity.x /= host.stats_component.Friction;
	
	if abs(host.velocity.x) > host.RUN_LIM:
		if host.velocity.x >= 0:
			host.velocity.x = host.RUN_LIM;
		else:
			host.velocity.x = host.RUN_LIM*-1;
		
	if host.input_component and host.input_component.get_jump_input(host) and host.is_on_floor():
		return_state = 'jump';
	
	
	if host.input_component and host.input_component.get_dash_input(host):
		return_state = 'dash';
		
		if host.get_node("R").is_colliding():
			if host.get_node("R2").is_colliding():
				return_state = 'wall_dash';
		elif host.get_node("L").is_colliding():
			if host.get_node("L2").is_colliding():
				return_state = 'wall_dash';
		host.screen_shake(1);
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0:
		host.velocity.y *= 1.05;
	
	check_raycast_step(host, delta);
	
	host.move_and_slide();
	
	return return_state;

func process(host, delta):
	if host.input_component and abs(host.input_component.get_move_axis(host)) > 0.01:
		if host.input_component.get_move_axis(host) < 0:
			host.facing = '_l';
		else:
			host.facing = '';
		host.animation.play("walk" + host.facing);
	#if host.input_component and host.input_component.get_dash_input():
		#host.animation.play("slash");

func check_raycast_step(host, delta):
	if not host.is_on_floor():
		return;
	
	if host.get_node("R").is_colliding():
		if host.get_node("R2").is_colliding():
			return;
		host.position.x += 1;
		host.position.y -= 16;
	elif host.get_node("L").is_colliding():
		if host.get_node("L2").is_colliding():
			return;
		host.position.x -= 1;
		host.position.y -= 16;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
