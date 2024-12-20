extends Node

const SPEED_LIM: float = 500.0;

var dampened = false;

func initialize(host, vars):
	host.velocity.y -= host.stats_component.JumpHeight; 

func enter(host):
	pass;

func exit(host):
	dampened = false;

func update(host, delta):
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis(host)) > 0.01:
		host.velocity.x += host.input_component.get_move_axis(host)*host.stats_component.Speed;
	
	host.velocity.x /= host.stats_component.AirResistance;
	#if (host.velocity.x < 0):
		#host.velocity.x += host.stats_component.AirResistance;
		#if host.velocity.x > 0:
			#host.velocity.x = 0;
	#elif (host.velocity.x > 0):
		#host.velocity.x -= host.stats_component.AirResistance;
		#if host.velocity.x < 0:
			#host.velocity.x = 0;
		
	if abs(host.velocity.x) > host.RUN_LIM:
		host.velocity.x = sign(host.velocity.x)*host.RUN_LIM;
	
	if not dampened and host.input_component and not host.input_component.get_jump_held(host):
		host.velocity.y *= 0.59375;
		dampened = true;
	
	if host.input_component and host.input_component.get_dash_input(host) and host.dash_timer >= host.States['dash'].DASH_COOLDOWN:
		return_state = 'dash';
		host.screen_shake(1);
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0:
		host.velocity.y *= 1.05;
	
	host.move_and_slide();
	
	if host.is_on_floor_only():
		host.just_landed = true;
		return "previous";
	else:
		return return_state;

func process(host, delta):
	pass;


func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
