extends Node

@export var SPEED_LIM: float = 300;

func enter(host):
	var stone_footstep = host.get_node("sfx/footstep_stone");
	stone_footstep.pitch_scale = 0.89;
	stone_footstep.play();

func exit(host):
	host.get_node("sfx/footstep_stone").stop();
	host.animation.stop();

func update(host, delta):
	
	if host.stats_component:
		host.stats_component.add_stam(0.1);
	
	var stone_footstep = host.get_node("sfx/footstep_stone");
	if host.is_on_floor():
		if not stone_footstep.playing:
			stone_footstep.play();
	elif not host.is_on_floor():
		if host.stats_component:
			host.stats_component.CoyoteTimer -= delta;
			print(host.stats_component.CoyoteTimer);
		stone_footstep.stop();
	
	#if sign(host.velocity.x) != sign(host.input_component.get_move_axis(host)):
		#host.velocity.x *= -1;
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis(host)) > 0.01:
		host.velocity.x += host.input_component.get_move_axis(host)*host.stats_component.Speed;
	elif host.input_component:
		return_state = 'idle';
		
		#host.velocity.x = 0.0;
	if host.stats_component:
		host.velocity.x /= host.stats_component.Friction;
	
	if abs(host.velocity.x) > SPEED_LIM:
		if host.velocity.x >= 0:
			host.velocity.x = SPEED_LIM;
		else:
			host.velocity.x = SPEED_LIM*-1;
	
	if abs(host.velocity.x) <= host.stats_component.Friction:
		host.velocity.x = 0;
		
	if host.input_component and host.input_component.get_jump_input(host) and host.is_on_floor():
		return_state = 'jump';
	elif host.input_component and host.stats_component and host.stats_component.CoyoteTimer > 0 and host.input_component.get_jump_input(host):
		return_state = 'jump';
	
	if host.input_component and host.input_component.get_dash_input(host) and host.stats_component and not host.stats_component.is_exhaust() and host.stats_component.Stamina >= host.stats_component.DashStamAmt:
		host.stats_component.add_stam(-host.stats_component.DashStamAmt);
		
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
		if host.input_component.get_move_axis(host) < -0.01:
			host.facing = '_l';
		elif host.input_component.get_move_axis(host) >= 0.01:
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
