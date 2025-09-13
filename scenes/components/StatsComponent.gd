extends Node2D

class_name StatsComponent;

@export var Speed: float = 0.0;
@export var RunSpeed: float = 0.0;
@export var JumpHeight: float = 36.0;
@export var DashSpeed: float = 36.0;
@export var FallSpeed: float = 1.1;

@export var Gravity: float = 14.14;
@export var Friction: float = 0.96;
@export var AirResistance: float = 0.5;

@export var MaxHealth: float = 50;
var Health = MaxHealth;

var Stagger: float = 0.0;
@export var Poise: float = 15.0;

@export var MaxStamina: float = 50;
var Stamina = MaxStamina;

@export var DashStamAmt: float = 15; 
@export var RunStamAmt:  float = 0.1;

@export var JumpBufferLen: float = 0.1;
var JumpBufferTime: float = 0.0;

@export var CoyoteTime: float = 1/20;
var CoyoteTimer: float = CoyoteTime;

@export var ui_component: EntityUIComponent;
@export var actor: Actor;

func _ready():
	Health = MaxHealth;
	Stamina = MaxStamina;
	if ui_component:
		ui_component.change_max_health(MaxHealth, true);
		ui_component.change_max_stam(MaxStamina, true);

func level_up():
	pass;

func _process(delta):
	
	if actor and is_dead():
		actor.kill();
	
	Stagger -= delta*(Poise/2.0);
	if Stagger < 0.0:
		Stagger = 0.0;
	elif Stagger >= Poise:
		Stagger = 0.0;
		get_parent().stun();

func refill_health():
	Health = MaxHealth;

func damage(amt, type := 'none'):
	Global.pause_game(0.1);
	Health -= amt;
	add_stagger(amt, type);
	if ui_component:
		ui_component.add_health(-amt);

func add_stagger(amt, type):
	Stagger += amt;

func get_stagger():
	return Stagger;

func add_stam(amt):
	Stamina += amt;
	if ui_component:
		ui_component.add_stam(amt);

func is_stunned():
	return Stagger >= Poise;

func is_exhaust():
	return Stamina <= 0;

func is_dead():
	return Health <= 0;
