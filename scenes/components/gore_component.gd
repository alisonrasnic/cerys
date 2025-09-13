extends AnimationPlayer

class_name GoreComponent;

@export var Sprites: Node2D;
@export var stats_component: StatsComponent;

var velocities = [];

func explode(intensity):
	if Sprites:
		var i = 0;
		Sprites.visible = true;
		for x in Sprites.get_children():
			var X = randi()%2;
			if X == 0:
				X = -1;
			var Y = randi()%2;
			if Y == 0:
				Y = -1;
			velocities.push_back(Vector2(intensity*X*(randf()+1)/2, intensity*Y*(randf()+1)/2));
			i += 1;
	
func _process(delta):
	if Sprites:
		if len(velocities) > 0:
			var children = Sprites.get_children();
			for x in range(0, len(children)):
				children[x].position += velocities[x];
				velocities[x].y += stats_component.Gravity;

func done():
	for x in Sprites.get_children():
		if x.position.y <= 500:
			return false;
	
	return true;
