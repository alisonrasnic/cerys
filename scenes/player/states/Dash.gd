extends Node

const DASH_DIST = 60.0*4;
const DASH_COOLDOWN: float = 0.75;

var frame = 0;
var max_frames = 8;

func initialize(host, vars):
	host.dash_timer = 0.0;
	host.velocity.y = 0.0;
	if host.facing == 'r':
		host.velocity.x = DASH_DIST/max_frames;		
	else:
		host.velocity.x = -DASH_DIST/max_frames;		
	host.collision_mask = 0b00000000_00000000_00000000_00001110;
	host.animation.play("slash");

func enter(host):
	pass;

func exit(host):
	pass;

func update(host, delta):
	
	var return_state = null;
	
	host.velocity.y = 0;
	
	check_raycast_step(host, delta);
	host.move_and_collide((host.velocity/60)/delta);
	frame += 1;
	
	if frame >= max_frames:
		frame = 0;
		host.velocity.x = 0;
		return_state = 'previous';
	
	return return_state;

func process(host, delta):
	pass;

func check_raycast_step(host, delta):
	if not host.is_on_floor():
		return;
	
	if host.get_node("R").is_colliding():
		host.position.x += 1;
		host.position.y -= 16;
	elif host.get_node("L").is_colliding():
		host.position.x -= 1;
		host.position.y -= 16;

func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		host.stats_component.damage(area.Damage);
		print("Trying damage...");
	elif area is HitboxComponent and area.ignore_hurtbox != host.hurtbox_component:
		var hb = area as HitboxComponent;
		if hb.dash_die:
			print("DIE!!");
			hb.get_parent().parry_dash_attack_receive();
		else:	
			print("why no die =( :", hb.dash_die);
		
