extends CharacterBody2D

# what things need to go into various entities?
# physics (handled in part by godot)
# stats
# control
# animation
# camera component (how does this entity impact the camera?)

class_name Player;

signal reset_level;

# credit to GDQuest on youtube for pushdown state machine tutorial
# 	https://www.youtube.com/watch?v=Ty4wZL7pDME
@onready var States = {
	'idle':   $States/Idle,
	'walk':   $States/Walk,
	'run':   $States/Run,
	'jump':   $States/Jump,
	'dash':   $States/Dash,
	'wall_dash':   $States/WallDash,
	'attack': $States/Attack,
	'block':  $States/Block,
	'parry':  $States/Parry,
	'parry_dash': $States/ParryDash,
}

var states_stack = [];
var state = null;

var player_state = PlayerState.new();

var dash_distance = 60.0*5;
var facing = '';
var dash_timer = 0.0;

var target;

var just_landed = false;
var land_timer = 0.0;

@export var input_component: InputComponent;
@export var hurtbox_component: HurtboxComponent;
@export var hitbox_component: HitboxComponent;
@export var stats_component: StatsComponent;
@export var animation: AnimationPlayer;

@export var SPEED_LIM: float = 300.0;
@export var RUN_LIM: float = 600.0;
@export var COYOTE_TIME: float = 0.1;

func _ready():
	states_stack.push_front(States['idle']);
	states_stack[0] = $States/Idle;
	state = states_stack[0];
	_change_state('idle');
	
	stats_component.refill_health();

func _physics_process(delta):
	
	var new_state = await state.update(self, delta);
	if new_state:
		_change_state(new_state);
	
func _process(delta):
	
	if is_on_floor():
		if stats_component:
			stats_component.CoyoteTimer = stats_component.CoyoteTime;
	
	#if position.y > 6000:
		#print("PLAYER FELL TO THEIR DEATH");
		#reset();
	
	dash_timer += delta;
	
	if facing != '_l':
		$Sprite2D.flip_h = false;
	else:
		$Sprite2D.flip_h = true;
	
	var new_state = state.process(self, delta);
	if new_state:
		_change_state(new_state);
		
	if stats_component:
		if stats_component.is_dead():
			print("PLAYER IS DEAD");
			reset();
	
	if is_on_floor_only():
		land_timer += delta;
	else:
		land_timer = 0;

func _change_state(new_state, vars := []):
	state.exit(self);
	
	if new_state != null:
		print("New state change: ", new_state);
	
	if new_state == 'previous':
		states_stack.pop_front();
	elif new_state in ['jump', 'dash', 'wall_dash']:
		states_stack.push_front(States[new_state]);
	else:
		var replacing_state = States[new_state];
		states_stack[0] = replacing_state;
		
	# if jump or if dash initialize those states
	if new_state in ['jump', 'dash', 'parry_dash', 'wall_dash']:
		States[new_state].initialize(self, vars);
	
	state = states_stack[0];
	if new_state != 'previous':
		state.enter(self);

func _on_hurtbox_component_area_entered(area):
	if area is HurtboxComponent:
		hitbox_component.hurtboxes_to_ignore.append(area);
		print("Ignoring area...");
	state._on_hurtbox_component_area_entered(self, area);

func _on_hurtbox_component_area_exited(area):
	if area is HurtboxComponent:
		var idx = hitbox_component.hurtboxes_to_ignore.find(area);
		if idx == -1:
			print("!!!!!!!");
		hitbox_component.hurtboxes_to_ignore.remove_at(hitbox_component.hurtboxes_to_ignore.find(area));
		for x in hitbox_component.hurtboxes_to_ignore:
			print("?????: ", x);
		print("Unignoring area...");

func _on_target_area_body_entered(body):
	target = body;
	if facing != '_l':
		dash_distance = (body.global_position.x - self.global_position.x) + body.get_width();
	else:
		dash_distance = (body.global_position.x - self.global_position.x) - get_width();
		
func screen_shake(amt):
	$Camera2D.shake(amt);

func reset():
	emit_signal("reset_level");
	velocity = Vector2.ZERO;
	stats_component._ready();

func stun():
	pass;

func get_width():
	return $CollisionComponent.shape.get_rect().size.x;

func save():
	pass;
	# we need to save:
	#  position
	#  weapon
	#  stats
	#  perks
	#  lore
