extends Node

const SPEED_LIM: int = 20;

func enter(host):
	pass;

func exit(host):
	pass;
		
func process(host, delta):
	if sign(host.velocity.x) != sign(host.input_component.get_move_axis(host)):
		host.velocity.x *= -1;
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis(host)) > 0.01:
		host.velocity.x += host.input_component.get_move_axis(host)*(sqrt(host.stats_component.Speed)/host.stats_component.Friction);
	
	if abs(host.velocity.x) > SPEED_LIM:
		var signs = sign(host.velocity.x);
		host.velocity.x = SPEED_LIM*signs;
	
	host.velocity.y += host.stats_component.Gravity;
	
	host.move_and_slide();
	
	if not host.input_component.get_block_input(host):
		return_state = 'idle';
	
	return return_state;

func update(host, delta):
	pass;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		#host.stats_component.damage(area.Damage);
		print("Trying damage...");
