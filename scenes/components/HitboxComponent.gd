extends Area2D

class_name HitboxComponent;

@export var stats_component: StatsComponent;
@export var ignore_hurtbox: HurtboxComponent;

func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox = area as HurtboxComponent;
		if hurtbox != ignore_hurtbox:
			stats_component.damage(hurtbox.Damage);
