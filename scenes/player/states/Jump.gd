extends Node

const SPEED_LIM: float = 200.0;

func initialize(host, vars):
	host.velocity.y -= host.stats_component.JumpHeight; 

func enter(host):
	pass;

func exit(host):
	pass;

func update(host, delta):
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis()) > 0.01:
		host.velocity.x += host.input_component.get_move_axis()*(sqrt(host.stats_component.Speed)/host.stats_component.Friction);
	
	if abs(host.velocity.x) > SPEED_LIM:
			var signs = sign(host.velocity.x);
			host.velocity.x = SPEED_LIM*signs;
	
	if host.input_component and host.input_component.get_dash_input() and host.dash_timer >= host.States['dash'].DASH_COOLDOWN:
		return_state = 'dash';
		host.screen_shake(1);
	
	host.velocity.y += host.stats_component.Gravity;
	if host.velocity.y > 0.0:
		host.velocity.y *= 1.05;
	
	host.move_and_slide();
	
	if host.is_on_floor_only():
		return "previous";
	else:
		return return_state;

func process(host, delta):
	pass;


func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
