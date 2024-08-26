extends Area2D

class_name HitboxComponent;

@export var dash_die: bool = false;
@export var stats_component: StatsComponent;
@export var ignore_hurtbox: HurtboxComponent;
var hurtboxes_to_ignore: Array;

func _on_area_entered(area):
	if area is HurtboxComponent and not area.Blocking:
		var hurtbox = area as HurtboxComponent;
		if hurtbox != ignore_hurtbox and hurtboxes_to_ignore.find(area) == -1:
			stats_component.damage(hurtbox.Damage);
