extends Node2D

class_name StatsComponent;

@export var Speed: float = 20.0;
@export var JumpHeight: float = 36.0;
@export var DashSpeed: float = 36.0;

@export var Gravity: float = 14.14;
@export var Friction: float = 0.96;

@export var MaxHealth: float = 50;
var Health = MaxHealth;

var Stagger: float = 0.0;
@export var Poise: float = 15.0;

@export var ui_component: EntityUIComponent;

func _ready():
	if ui_component:
		ui_component.change_max_health(MaxHealth, true);

func level_up():
	pass;

func _process(delta):
	Stagger -= delta*(Poise/2.0);
	if Stagger < 0.0:
		Stagger = 0.0;
	elif Stagger >= Poise:
		Stagger = 0.0;
		get_parent().stun();

func damage(amt, type := 'none'):
	Health -= amt;
	add_stagger(amt, type);
	if ui_component:
		ui_component.add_health(-amt);

func add_stagger(amt, type):
	Stagger += amt;

func get_stagger():
	return Stagger;

func is_stunned():
	return Stagger >= Poise;

func is_dead():
	return Health <= 0;
