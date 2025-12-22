class_name Powerup extends Node


"""
Base class for all Powerups
"""

## Global modifier for damage
static var damage_modifier := 0

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


## Simple frequency counter. Does nothing if level is 0
func _process(delta: float) -> void:
	if level == 0:
		return

	_counter += delta
	if _counter < frequency:
		return
	_counter -= frequency
	process_callback()
