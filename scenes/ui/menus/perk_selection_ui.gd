extends CanvasLayer

var perks = [
	load("res://assets/sprites/ui/menus/dmg_10_perk.png"),
	load("res://assets/sprites/ui/menus/def_10_perk.png"),
	load("res://assets/sprites/ui/menus/chain_parry_dash_perk.png"),
	load("res://assets/sprites/ui/menus/lantern_25_perk.png"),
];

@export var sprite_1: Sprite2D;
@export var sprite_2: Sprite2D;
@export var sprite_3: Sprite2D;

func _ready():
	var count = 0;
	while count < 3:
		var rnd = randi()%len(perks);
		if count == 0:
			sprite_1.texture = perks[rnd];
		elif count == 1:
			sprite_2.texture = perks[rnd];
		elif count == 2:
			sprite_3.texture = perks[rnd];
		count += 1;
		
func _process(delta):
	pass
