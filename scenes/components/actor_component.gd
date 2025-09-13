extends Node2D

class_name Actor;

@export var audio_component: RoundRobinSound2D;
@export var sprite: Sprite2D;
@export var gore_component: GoreComponent;
@export var hitbox_component: HitboxComponent;

func kill():
	sprite.visible = false;
	if hitbox_component:
		hitbox_component.disable();
	
	if gore_component:
		gore_component.explode(3.2);
	
	if (audio_component and audio_component.done()) or (gore_component and gore_component.done()):
		var parent = get_parent();
		if parent:
			parent.queue_free();
