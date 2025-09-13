extends CharacterBody2D

var target_pos: Vector2;
var active: bool = false;
var active_timer = 0.0;

@export var stats: StatsComponent;

func _ready():
	target_pos = global_position;

func reset():
	active = false;
	active_timer = 0.0;
	$HurtboxComponent/CollisionShape2D.disabled = true;
	visible = false;
	position = Vector2i.ZERO;
	print("PROJ RESET");

func _process(delta):
	if active:
		if $HurtboxComponent/CollisionShape2D.disabled:
			$HurtboxComponent/CollisionShape2D.disabled = false;
		active_timer += delta;
		
		if active_timer > 3.5:
			reset();
		var dir = (global_position-(target_pos+Vector2(4,-4))).normalized()
		velocity = dir*-1*stats.Speed;
		
		const reset_dist = 4;
		if abs(global_position.x - (target_pos.x+4)) <= reset_dist and abs(global_position.y - (target_pos.y-4)) <= reset_dist:
			reset();
		
		move_and_slide();

func parry_receive():
	reset();

func stun():
	pass;
