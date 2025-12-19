class_name Powerup extends Object


"""
Base class for all Powerups
Subclass this and:
	- override process_callback for actions that take place periodically
	- override stack_callback for changes when levelling up this Powerup
	- set frequency and name in _init
"""

## Convenience to interact with player
static var player: Player = null

## Level of current Powerup
var level := 0

## Frequency between calls of process_callback
var frequency := 0.0

## Name of the current Powerup
var name := "undefined"

## Counter for frequency
var _counter := 0.0


## Virtual, override with own logic for Powerup
func process_callback():
	pass


## Override with own logic for levelling up Powerup
func stack_callback():
	level += 1


## Call this from _process
# Will keep track of Powerup frequency and call process_callback
# periodically
func tick(delta: float) -> bool:
	_counter += delta
	if _counter < frequency:
		return false
	_counter -= frequency
	process_callback()
	return true
