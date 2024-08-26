extends Node

func enter(host):
	host.velocity.y = 0.1;
	host.animation.play("RESET");

func exit(host):
	pass;

func update(host, delta):
	
	var return_state = null;
	var input = host.input_component;
	
	if input and abs(input.get_move_axis()) > 0.01:
		host.velocity.x += input.get_move_axis()*(sqrt(host.stats_component.Speed)/host.stats_component.Friction);
		return_state = 'walk';
	elif input:
		host.velocity.x = 0.0;
		
	if input and input.get_jump_input() and host.is_on_floor():
		return_state = 'jump';
	
	if input and input.get_parry_input():
		return_state = 'parry';
	
	if input and input.get_attack_input():
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
