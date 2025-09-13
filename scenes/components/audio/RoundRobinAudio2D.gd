extends Node2D

class_name RoundRobinSound2D;

signal finished;

var old_playing: bool = false;
@export var playing: bool = false;
@export var vol = 0.0;

@export var streams: Array = [];
var idx = 0;

func _ready():
	$AudioStreamPlayer2D.max_distance = 500;
	$AudioStreamPlayer2D.connect("finished", is_finished);

func play_rand():
	$AudioStreamPlayer2D.volume_db = vol;
	var pitch = randf() * 0.5 + 0.75;
	idx = randi() % len(streams);
	$AudioStreamPlayer2D.stream = streams[idx];
	$AudioStreamPlayer2D.pitch_scale = pitch;
	$AudioStreamPlayer2D.play();

func play_next():
	$AudioStreamPlayer2D.volume_db = vol;
	$AudioStreamPlayer2D.stream = streams[idx];
	$AudioStreamPlayer2D.play();
	idx = idx + 1;
	if idx >= len(streams):
		idx = 0;

func _process(delta):
	if playing and not old_playing:
		play_next();
	old_playing = playing;

func is_finished():
	emit_signal("finished");
	
func done():
	return not $AudioStreamPlayer2D.playing;
