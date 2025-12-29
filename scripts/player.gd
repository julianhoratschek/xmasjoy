class_name Player extends Node2D

"""
Class for Player-character
"""

## How often shall we create footsteps while moving?
const StepsFrequency := 0.2


## Emitted when player is leveled up
signal level_up()

## Emitted then player collects xp
signal xp_collected()

## Emitted when health reached 0
signal dead()


## Movement speed
var speed := 200.0

## Player health
var health := 100

## Invincibility-Frames after hit
var iframes_time := 0.8

## Current player XP
var xp := 0

## How much XP do we need for the next level?
var next_level_xp := 30

## Current player level
var current_level := 0

## Counter for invicibility frames
var _iframes_counter := 0.0

## Counter for StepsFrequency
var _steps_counter := 0.0

## Pool for footsteps
@onready var _steps_pool := ObjectPool.new(
	preload("res://prefabs/steps.tscn"),
	get_parent()
)


## Add a new power-up or level up an existing one
func add_powerup(powerup: Powerup):
	powerup.stack_callback()


## Called when player was hit by an enemy
# TODO: Extend for enemy-bullets?
func hit_by(enemy: Enemy) -> void:
	health -= enemy.damage
	$HealthBar.value = health

	if health <= 0:
		dead.emit()
		return

	_iframes_counter = iframes_time


## Set maximum size for footsteps pool
func _ready() -> void:
	_steps_pool.max_size = 20


## Simple movement and call to Powerups
func _process(delta: float):
	# Movement
	var dir := Input.get_vector(&"gme_left", &"gme_right", &"gme_up", &"gme_down")

	# Display footsteps when moving
	if not dir.is_zero_approx():
		if _steps_counter > 0:
			_steps_counter -= delta
		else:
			_steps_counter += StepsFrequency
			var new_step = _steps_pool.pop()
			if new_step:
				new_step.position = position
				new_step.rotation = dir.angle()

	position += dir * speed * delta

	# iframes-flicker
	# TODO: this could be a simple shader
	modulate.a = 1.0
	if _iframes_counter > 0.0:
		_iframes_counter -= delta
		modulate.a = sin(_iframes_counter * 2 * PI * 9)


## Hit-detection on player
# TODO: Extend for enemy-projectiles?
func _on_hit_area_entered(area: Area2D) -> void:
	var body = area.get_parent()

	if body is Enemy and _iframes_counter <= 0.0:
		hit_by(body)

	elif body is XPBall:
		xp += body.amount
		body.collect()

		# Level-curve
		if xp >= next_level_xp:
			var next_level := current_level + 1
			next_level_xp = 15 * next_level ** 2 + 50 * next_level + 0
			current_level = next_level
			level_up.emit()

		xp_collected.emit()


## Starts xp-float towards player
func _on_collection_area_entered(area: Area2D) -> void:
	var body = area.get_parent()

	if body is XPBall:
		body.move_to_player = true


## Lets xp stop floating to player
func _on_collection_area_exited(area: Area2D) -> void:
	var body = area.get_parent()

	if body is XPBall:
		body.move_to_player = false


## Fade-out speech label from beginning
func _on_speech_finished() -> void:
	var tween := create_tween().tween_property(
		$SpeechLabel,
		"modulate",
		Color(0, 0, 0, 0),
		0.8)
	tween.finished.connect($SpeechLabel.queue_free)
