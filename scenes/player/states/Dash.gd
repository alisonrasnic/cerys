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
	
	host.move_and_collide((host.velocity/60)/delta);
	frame += 1;
	
	if frame >= max_frames:
		frame = 0;
		host.velocity.x = 0;
		return_state = 'previous';
	
	return return_state;

func process(host, delta):
	pass;

func _on_hurtbox_component_area_entered(area):
	pass;
