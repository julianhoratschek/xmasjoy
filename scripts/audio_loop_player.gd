extends Node2D


"""
Very simple audio looper
"""

## All audio files
@export var audio_files: Array[AudioStream] = []

## AudioPlayer isntance
@onready var player := $AudioStreamPlayer2D


## Selects a new track from audio_files, does not play the last track
func _select_new():
	var old_stream = player.stream
	while old_stream == player.stream:
		player.stream = audio_files.pick_random()
	player.play()


## Selects new track, when the old one finished
func _on_audio_finished():
	_select_new()


## Starts by selecting a random track
func _ready():
	_select_new()
