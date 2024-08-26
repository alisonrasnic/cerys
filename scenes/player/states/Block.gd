extends Node


func _on_hurtbox_component_area_entered(host, area):
	if host.stats_component and area is HurtboxComponent:
		#host.stats_component.damage(area.Damage);
		print("Trying damage...");
