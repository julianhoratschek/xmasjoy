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

## Current player XP
var xp := 0

## How much XP do we need for the next level?
var _level_xp := 30

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


## Simple movement and call to Powerups
func _process(delta: float):
	var dir := Input.get_vector(&"gme_left", &"gme_right", &"gme_up", &"gme_down")
	position += dir * speed * delta


## Hit-detection on player
# TODO: Extend for enemy-projectiles?
func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()

	if body is Enemy:
		hit_by(body)

	elif body is XPBall:
		xp += body.amount
		body.collect()

		if xp >= _level_xp:
			xp = 0
			_level_xp += 20
			level_up.emit()
