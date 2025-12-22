class_name Present extends Node2D


"""
Present to collect
this represents the main goal of the game
"""


## States of the present
enum State {
	## Wait for player to enter action area
	Waiting,

	## Player is within action area
	InRange,

	## Present was collected and waits for respawn
	Teleporting
}


## Emitted when the present is spawned
signal teleported()

## Emitted when the player collected this present
signal collected()


## Player Instance
@export var player: Player = null

## Time to wait between animation changes
@export var wait_time_min := 1.0
@export var wait_time_max := 3.0

## Range to teleport from the player after collection
@export var min_teleport_range := 600.0
@export var max_teleport_range := 1200.0

## Waiting time between collection and new spawn
@export var min_teleport_delay := 5.0
@export var max_teleport_delay := 15.0

## Values to add per collection step
@export var value_step := 4.0

## Wait time per collection step
@export var step_duration := 0.2

## Counter for collection step and waiting time for respawn
var _step_counter := 0.0

## Current state
var _state := State.Waiting


## Respawn present inside a radius around the player
func _teleport() -> void:
	var dir := Vector2.UP.rotated(randf_range(0.0, 2 * PI))
	position = player.position + dir * randf_range(min_teleport_range, max_teleport_range)

	_state = State.Waiting

	$Area2D.process_mode = Node.PROCESS_MODE_INHERIT
	$TextureProgressBar.value = 0

	show()
	teleported.emit()


## Player entered the collection area
# Setup of the scene tests only on "player"-collision layer for collision
func _on_area_entered(_area: Area2D):
	if _state == State.Waiting:
		_state = State.InRange


## Player exited collection area
func _on_area_exited(_area: Area2D):
	if _state == State.InRange:
		_state = State.Waiting


## A change occurred on the progress bar, tests if the present was fully
# collected and sets state to teleporting.
func _on_progress_bar_changed(value: float):
	if value < 100:
		return

	_state = State.Teleporting
	$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
	_step_counter = randf_range(min_teleport_delay, max_teleport_delay)
	value = 0
	hide()

	collected.emit()


## Timeout to oversee animation changes
func _on_timer_timeout() -> void:
	var animation_name: String = [&"", &"shake", &"jump"].pick_random()

	match animation_name:
		# Have a chance to play no animation at all
		&"":
			$Timer.start(randf_range(wait_time_min, wait_time_max))
			return

		# Present should not jump when player tries to collect it
		&"jump" when _state == State.InRange:
			animation_name = &"shake"

	$AnimationPlayer.play(animation_name)


## Oversees Player input on collection and teleportation delay
func _process(delta: float):
	if _step_counter > 0:
		_step_counter -= delta
		return

	match _state:
		State.InRange:
			if Input.is_action_pressed(&"gme_action"):
				$TextureProgressBar.value += value_step
				_step_counter += step_duration

		State.Teleporting:
			_teleport()

		State.Waiting:
			pass


## After finishing an animation, start timer until new animation
func _on_animation_finished(_animation_name: StringName):
	$AnimationPlayer.stop()
	$Timer.start(randf_range(wait_time_min, wait_time_max))
