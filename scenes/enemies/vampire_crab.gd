extends CharacterBody2D

@export var input_component: InputComponent;
@export var stats_component: StatsComponent;

func _physics_process(delta):
	if input_component and stats_component and input_component is AIComponent:
		velocity.x = stats_component.Speed*input_component.get_move_axis(self);
	
	move_and_slide();
