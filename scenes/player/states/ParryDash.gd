extends Node

var is_dashing = false;

var frame = 0;
var max_frames = 8;

func enter(host):
	pass;

func initialize(host, vars):
	print("INITIALIZED PARRY DASH VARS[0]", vars[0]);
	await get_tree().create_timer(vars[0]).timeout;
	host._change_state('idle');

func exit(host):
	pass;

func update(host, delta):
	var return_state = null;
	var input = host.input_component;
	
	if input and input.get_dash_input():
		start_dash(host);
	
	host.velocity.y = 0;
	
	if is_dashing:
		print(host.velocity.x);
		
		host.move_and_collide((host.velocity/60)/delta);
		frame += 1;
		
		if frame >= max_frames:
			frame = 0;
			host.velocity.x = 0;
			end_dash(host);
			return_state = 'idle';
			print("POSITION: ", host.position.x);
	
	return return_state;

func start_dash(host):
	is_dashing = true;
	host.velocity.y = 0.0;
	host.get_node("TargetArea").get_node("CollisionShape2D").disabled = true;
	var particles = host.get_node("DashParticles");
	particles.emitting = true;
	particles.amount = 500+abs(host.dash_distance);
	particles.amount = clamp(particles.amount, 500, 5000);
	print("Dash Distance is: ", host.dash_distance);
	host.velocity.x = host.dash_distance/max_frames;		
	print("VELOCITY INIT IS: ", host.velocity.x);
	host.collision_mask = 0b00000000_00000000_00000000_00001011;
	host.animation.play("slash");
	print("POSITION: ", host.position.x);

func end_dash(host):
	is_dashing = false;
	host.collision_mask = 0b00000000_00000000_00000000_00001110;
	host.get_node("DashParticles").emitting = false;
	host.get_node("TargetArea").get_node("CollisionShape2D").disabled = false;
	var enemy = host.target;
	enemy.parry_dash_attack_receive();
		
func process(host, delta):
	pass;

func _on_hurtbox_component_area_entered(area):
	pass;
		
