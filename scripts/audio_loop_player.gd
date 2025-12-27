extends Node2D


@export var audio_files: Array[AudioStream] = []
@onready var player := $AudioStreamPlayer2D

func _select_new():
	player.stream = audio_files.pick_random()
	player.play()

func _on_audio_finished():
	_select_new()

func _ready():
	_select_new()
