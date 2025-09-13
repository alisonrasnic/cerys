extends Node

func enter(host):
	host.animation.play("idle");

func exit(host):
	pass;

func update(host, delta):
	
	if host.stats_component:
		host.stats_component.add_stam(0.15);
	
	var return_state = null;
	var input = host.input_component;
	
	if input and abs(input.get_move_axis(host)) > 0.01:
		host.velocity.x += input.get_move_axis(host)*(sqrt(host.stats_component.Speed));
		return_state = 'walk';
	
	if host.stats_component:
		host.velocity.x /= host.stats_component.Friction;
	
	#if abs(host.velocity.x) > host.SPEED_LIM:
		#if host.velocity.x >= 0:
			#host.velocity.x = host.SPEED_LIM;
		#else:
			#host.velocity.x = host.SPEED_LIM*-1;
	
	if input and input.get_jump_input(host) and host.is_on_floor():
		return_state = 'jump';
	#elif host.just_landed and host.land_timer <= host.COYOTE_TIME:
		#return_state = 'jump';
	
	if input and input.get_parry_input(host):
		return_state = 'parry';
	
	if input and input.get_attack_input(host):
		return_state = 'attack';
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0:
		host.velocity.y *= 1.05;
	
	host.move_and_slide();
	
	return return_state;

func process(host, delta):
	pass;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
