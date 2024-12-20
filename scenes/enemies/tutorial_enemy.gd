extends CharacterBody2D

const ATTACK = 1.5;

@export var attack_timer: float = 0.0;
@export var last_player_pos = Vector2i.ZERO;

@export var stats_component:   StatsComponent;
@export var hitbox_component:  HitboxComponent;
@export var ui_component:      EntityUIComponent;
@export var input_component:   InputComponent;
@export var sfx: 			   Node2D;

var facing = '_l';

func get_width():
	return $CollisionShape2D.shape.get_rect().size.x;

func _process(delta):
	if not $AnimationPlayer.is_playing() and $AnimationPlayer.has_animation("idle"):
		$AnimationPlayer.play("idle" + facing);
	attack_timer += delta;
	if attack_timer >= ATTACK and input_component == null and not has_node("Projectiles"):
		attack_timer = 0.0;
		$AnimationPlayer.play("attack");
	elif attack_timer >= ATTACK and not has_node("Projectiles"):
		var ai = input_component as AIComponent;
		if ai.get_attack_input(self):
			attack_timer = 0.0;
			$AnimationPlayer.play("attack" + facing);
	if stats_component:
		if stats_component.is_dead():
			if sfx:
				sfx.get_node("Death").play_rand();
			visible = false;
			process_mode = Node.PROCESS_MODE_DISABLED;
	
	if input_component is AIComponent:
		var ai = input_component as AIComponent;
		var player = get_tree().get_nodes_in_group('player')[0];
		if player:
			ai.update_player_position(player.global_position + Vector2(2, -4));
			if ai.get_move_axis(self) != 0 and stats_component:
				velocity.x = stats_component.Speed*input_component.get_move_axis(self);
			else:
				velocity.x = 0;
			
			if ai.get_move_y_axis(self) != 0 and stats_component:
				velocity.y = stats_component.Speed*input_component.get_move_y_axis(self);
			else:
				velocity.y = 0;
				
			if ai.aggro and attack_timer >= ATTACK:
				if get_node("Projectiles"):
					attack_timer = 0.0;
					var cur_proj = get_node("Projectiles/" + str(ai.cur_proj));
					cur_proj.visible = true;
					cur_proj.get_node("HurtboxComponent/CollisionShape2D").disabled = false;
					if not cur_proj.active:
						cur_proj.target_pos = ai.pos;
						cur_proj.active = true;
						if ai.cur_proj == 1:
							teleport_around();
							cur_proj.reset();
							attack_timer -= 2.5;
		
		if velocity.x == 0 and velocity.y == 0:
			ai.aggro = false;
		
	
	move_and_slide();

func stun():
	pass;
	#$AnimationPlayer.play("stun");

func teleport_around():
	var tele_dist = 100;
	if position.distance_to(last_player_pos) < tele_dist:
		var rand_pos = randi() % tele_dist;
		var old_x = position.x;
		position.x = last_player_pos.x + (rand_pos-(tele_dist/2));
		
		if $CollisionCheck.is_colliding():
			position.x = old_x;

func parry_receive():
	if stats_component:
		stats_component.add_stagger(16.0, null);
	$Parry.play();
	if stats_component and stats_component.is_stunned():
		print($AnimationPlayer.current_animation_length);
		print($AnimationPlayer.current_animation_position);
		#return $AnimationPlayer.current_animation_length - $AnimationPlayer.current_animation_position;
		return 2.0;
	else:
		return null;

func parry_dash_attack_receive():
	var enemy_animplayer = get_node("AnimationPlayer");
	enemy_animplayer.play("explode_death");
	get_node("DashDeath").play();
	await get_node("DashDeath").finished;
	visible = false;
	process_mode = Node.PROCESS_MODE_DISABLED;
