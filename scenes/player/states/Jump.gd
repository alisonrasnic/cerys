extends Node

@export var speed_lim: float = 200.0;

var dampened = false;
var jump_buffer = false;

func initialize(host, vars):
	host.velocity.y = 0;
	host.velocity.y -= host.stats_component.JumpHeight*host.stats_component.AirResistance;
	host.animation.play("jump");

func enter(host):
	if host.input_component and host.input_component.get_sprint_input(host):
		if host.stats_component:
			host.stats_component.add_stam(-host.stats_component.RunStamAmt*20);
	#speed_lim = host.velocity.x;

func exit(host):
	dampened = false;
	host.animation.play("land");

func update(host, delta):
	
	var return_state = null;
	
	if host.input_component:
		host.velocity.x += host.input_component.get_move_axis(host)*host.stats_component.Speed/20;
	
	#if (host.velocity.x < 0):
		#host.velocity.x += host.stats_component.AirResistance;
		#if host.velocity.x > 0:
			#host.velocity.x = 0;
	#elif (host.velocity.x > 0):
		#host.velocity.x -= host.stats_component.AirResistance;
		#if host.velocity.x < 0:
			#host.velocity.x = 0;
		#
	if host.velocity.x > speed_lim:
		host.velocity.x = speed_lim;
	elif host.velocity.x < -speed_lim:
		host.velocity.x = -speed_lim;
	
	if not dampened and host.input_component and not host.input_component.get_jump_held(host):
		host.velocity.y *= 0.59375;
		dampened = true;
	
	if host.input_component and host.input_component.get_dash_input(host) and host.dash_timer >= host.States['dash'].DASH_COOLDOWN:
		return_state = 'dash';
		host.screen_shake(1);
	
	if jump_buffer:
		if host.stats_component and host.stats_component.JumpBufferTime < host.stats_component.JumpBufferLen:
			host.stats_component.JumpBufferTime += delta;
		elif host.stats_component and host.stats_component.JumpBufferTime >= host.stats_component.JumpBufferLen:
			host.stats_component.JumpBufferTime = 0;
			jump_buffer = false;
	
	if host.input_component and host.input_component.get_jump_input(host):
		jump_buffer = true;
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0 and host.stats_component:
		host.velocity.y *= host.stats_component.FallSpeed;
	host.velocity.y *= 1/host.stats_component.AirResistance;
	
	host.move_and_slide();
	
	if host.is_on_floor_only():
		host.just_landed = true;
		if jump_buffer:
			jump_buffer = false;
			return "jump";

		return "previous";
	else:
		return return_state;

func process(host, delta):
	pass;


func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
