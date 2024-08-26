extends Node

const SPEED_LIM: float = 30.1;

var buffer_next_attack = false;
var num = 1;

func enter(host):
	host.animation.play("slash");

func exit(host):
	pass;

func process(host, delta):
	if sign(host.velocity.x) != sign(host.input_component.get_move_axis()):
		host.velocity.x *= -1;
	
	var return_state = null;
	
	if host.input_component and abs(host.input_component.get_move_axis()) > 0.01:
		host.velocity.x += host.input_component.get_move_axis()*(sqrt(host.stats_component.Speed)/host.stats_component.Friction);
	
	if abs(host.velocity.x) > SPEED_LIM:
			var signs = sign(host.velocity.x);
			host.velocity.x = SPEED_LIM*signs;
	
	if not host.animation.is_playing():
		if buffer_next_attack:
			if num > 1:
				host.animation.play("slash_" + str(num));
			else:
				host.animation.play("slash");
			buffer_next_attack = false;
		else:
			return_state = 'idle';
			buffer_next_attack = false;
			num = 1;
	else:
		if host.input_component and host.input_component.get_attack_input() and not buffer_next_attack:
			buffer_next_attack = true;
			num += 1;
			if num > 4:
				num = 1;
	
	host.velocity.y += host.stats_component.Gravity;
	
	host.move_and_slide();
	
	return return_state;

func update(host, delta):
	pass;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
