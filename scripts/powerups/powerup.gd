class_name Powerup extends Node


"""
Base class for all Powerups
"""


signal leveled_up(new_level: int)

## Global modifier for damage
static var damage_modifier := 0

## Global modifier for freqeuncy of callbacks
static var frequency_modifier := 0.0

## Name to show on powerup-selection
@export var display_name := ""

## Image to display on powerup-selection
@export var display_image: Texture = null

## Level of current Powerup
@export var level := 0

## Frequency between calls of process_callback
@export var frequency := 0.0

## Counter for frequency
var _counter := 0.0


## Virtual, override with own logic for Powerup
func process_callback():
	pass


## Override with own logic for levelling up Powerup
func stack_callback():
	level += 1
	leveled_up.emit(level)


## Simple frequency counter. Does nothing if level is 0
func _process(delta: float) -> void:
	if level == 0:
		return

	_counter -= delta
	if _counter > 0:
		return
	_counter += frequency - Powerup.frequency_modifier
	process_callback()
