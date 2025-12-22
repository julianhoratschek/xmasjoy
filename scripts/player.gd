class_name Player extends Node2D

"""
Class for Player-character
"""

## Emitted when player is leveled up
signal level_up()

## Movement speed
var speed := 200.0

## Player health
var health := 100

## Invincibility-Frames after hit
var iframes_time := 0.8

## Current player XP
var xp := 0

## How much XP do we need for the next level?
var _level_xp := 30

## Counter for invicibility frames
var _iframes_counter := 0.0


const StepsFrequency := 0.2
var _steps_counter := 0.0
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
		# TODO: Game over
		pass

	_iframes_counter = iframes_time


func _ready() -> void:
	_steps_pool.max_size = 50


## Simple movement and call to Powerups
func _process(delta: float):
	# Movement
	var dir := Input.get_vector(&"gme_left", &"gme_right", &"gme_up", &"gme_down")

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
func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()

	if body is Enemy and _iframes_counter <= 0.0:
		hit_by(body)

	elif body is XPBall:
		xp += body.amount
		body.collect()

		if xp >= _level_xp:
			xp = 0
			_level_xp += 20
			level_up.emit()
